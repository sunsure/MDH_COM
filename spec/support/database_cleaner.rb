RSpec.configure do |config|
  config.before :each do
    DatabaseCleaner.strategy = :truncation
  end

  config.after :each do
    DatabaseCleaner.clean
  end
end