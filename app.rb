require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)
require_relative 'routes/concerns/init'
require_relative 'services/init'

class MyApp < Sinatra::Base
  Bundler.require(environment)
  Dotenv.load(".env.#{environment}")

  DB = Sequel.connect(ENV.fetch("DATABASE_URL"))
  DB.extension(:pagination)
  require_relative 'models/init'

  require_relative 'routes/init'
  require_relative 'serializers/init'
  # binding.pry
end
