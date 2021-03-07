require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

class MyApp < Sinatra::Base
  Bundler.require(environment)
  Dotenv.load(".env.#{environment}")
  Sequel.connect(ENV.fetch("DATABASE_URL"))
  require_relative 'routes/init'
  require_relative 'models/init'
  # binding.pry
end
