ENV['APP_ENV'] = 'test'
require 'rubygems'
require 'bundler/setup'
Bundler.require(:default, :test)
Dotenv.load(".env.test")
require_relative '../app.rb'
DatabaseCleaner[:sequel].strategy = :truncation
DatabaseCleaner[:sequel].db = Sequel.connect(ENV.fetch("DATABASE_URL"))

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
  conf.include FactoryBot::Syntax::Methods

  conf.before(:suite) do
    FactoryBot.find_definitions
  end

  conf.before(:all) do
    DatabaseCleaner.clean
  end

  conf.before :each do
    DatabaseCleaner[:sequel].start
  end

  conf.after :each do
    DatabaseCleaner[:sequel].clean
  end
end
