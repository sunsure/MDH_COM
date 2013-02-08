# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rspec'
require 'capybara/poltergeist'
Capybara.javascript_driver = :poltergeist

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Fix someone else's mistake with including Capybara
  config.include Capybara::DSL

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = false

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"
end

def login_as(user)
  request.cookies[:auth_token] = user.try(:auth_token)
end

def simulate_login(user, confirmed, options={})
  user.update_attribute(:confirmed_at, Time.zone.now)
  if confirmed
    user.update_attribute(:confirm_token, nil)
  end
  visit login_path
  fill_in "email", with: user.email

  if options[:failure]
    fill_in "password", with: "this is not my password"
  else
    fill_in "password", with: user.password
  end

  if options[:remember_me]
    find(:css, "#remember_me").set(true)
  end
  click_button "Login"
end

def stub_current_user(spec_type=[], options={})
  if options[:as_nil].present?
    @user = nil
  else
    @user = FactoryGirl.create(:user_with_roles, with_roles: ["admin"])
  end
  if spec_type.include?(:view)
    view.stub(:current_user, @user).and_return(@user)
  end
  if spec_type.include?(:can_can_controller)
    controller.stub!(:current_user, @user).and_return(@user)
  end
  # Add more stubs here as needed
end


# See: https://gist.github.com/1353500
# Use: it { should accept_nested_attributes_for(:association_name).and_accept({valid_values => true}).but_reject({ :reject_if_nil => nil })}
RSpec::Matchers.define :accept_nested_attributes_for do |association|
  match do |model|
    @model = model
    @nested_att_present = model.respond_to?("#{association}_attributes=".to_sym)
    if @nested_att_present && @reject
      model.send("#{association}_attributes=".to_sym,[@reject])
      @reject_success = model.send("#{association}").empty?
    end
    model.send("#{association}").clear
    if @nested_att_present && @accept
      model.send("#{association}_attributes=".to_sym,[@accept])
      @accept_success = ! (model.send("#{association}").empty?)
    end
    @nested_att_present && ( @reject.nil? || @reject_success ) && ( @accept.nil? || @accept_success )
  end

  failure_message_for_should do
    messages = []
    messages << "accept nested attributes for #{association}" unless @nested_att_present
    messages << "reject values #{@reject.inspect} for association #{association}" unless @reject_success
    messages << "accept values #{@accept.inspect} for association #{association}" unless @accept_success
    "expected #{@model.class} to " + messages.join(", ")
  end

  description do
    desc = "accept nested attributes for #{expected}"
    if @reject
      desc << ", but reject if attributes are #{@reject.inspect}"
    end
  end

  chain :but_reject do |reject|
    @reject = reject
  end

  chain :and_accept do |accept|
    @accept = accept
  end
end

# TODO: add rspec matcher for have_ability
