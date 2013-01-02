# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rspec'

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
  config.use_transactional_fixtures = true

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

def stub_current_user(spec_type, options={})
  @user = FactoryGirl.create(:user_with_roles, with_roles: ["admin"])
  case spec_type
  when :view
    if options[:as_nil].present?
      view.stub(:current_user, nil)
    else
      view.stub(:current_user, @user).and_return(@user)
    end
  when :can_can_controller
    controller.stub!(:current_user, @user).and_return(@user)
  when :both
    view.stub(:current_user, @user).and_return(@user)
    controller.stub!(:current_user, @user).and_return(@user)
  end
end

# TODO: add rspec matcher for accepts_nested_attributes_for
