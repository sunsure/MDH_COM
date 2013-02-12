source 'https://rubygems.org'

gem 'rails', '3.2.11'

# Bundle edge Rails instead:
# gem 'rails', git: 'git://github.com/rails/rails.git'

gem 'pg'
gem 'haml-rails'
gem 'strong_parameters'
gem 'cancan'
gem 'simple_form'
gem 'redcarpet'
gem 'less-rails'
gem 'twitter-bootstrap-rails', git: 'git://github.com/seyhunak/twitter-bootstrap-rails.git'
gem 'kaminari'
gem 'acts-as-taggable-on'
gem 'pygments.rb'
gem 'exception_notification'
gem 'recaptcha', :require => 'recaptcha/rails'
gem 'ancestry'
gem 'rmagick'
gem 'carrierwave'
gem 'texticle', '~> 2.0', require: 'texticle/rails'

unless RUBY_PLATFORM =~ /darwin/i
  gem 'rb-inotify', '~> 0.8.8'
end


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  gem 'libv8', '~> 3.11.8'
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', platforms: :ruby

  gem 'uglifier', '>= 1.0.3'
end

group :test do
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'capybara', '1.1.2'
  gem 'launchy'
  gem 'poltergeist'
  gem 'guard-rspec'
  gem 'rb-fsevent', '~> 0.9.1', require: false
end

group :test, :development do
  gem 'rspec-rails'
end

group :development do
  gem 'mail_view', :git => 'https://github.com/37signals/mail_view.git'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
