class MyApp < Sinatra::Base
  Bundler.require(environment)
  Dotenv.load(".env.#{environment}")

  DB = Sequel.connect(ENV.fetch("DATABASE_URL"))
  DB.extension(:pagination)
  require_all 'app/**/init.rb'
end
