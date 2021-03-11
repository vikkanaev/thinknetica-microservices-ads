require_relative './config/app_init'
require_relative './config/environment'

class MyApp < Sinatra::Base
  configure do
    I18n.load_path = ["./config/locales/ru.yml"]
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
