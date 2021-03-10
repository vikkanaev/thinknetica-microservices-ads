require 'active_support/all'
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

  configure do
    I18n.load_path = ["./locales/ru.yml"]
    I18n.default_locale = :ru
  end

  configure :development do
    set :show_exceptions, false
  end

  configure :test do
    set :show_exceptions, false
    set :raise_errors, false
  end
end
