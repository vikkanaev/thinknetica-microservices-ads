require 'sinatra'
require "sinatra/reloader" if development?
require_relative 'routes/init'

class MyApp < Sinatra::Base
  configure :development do
    enable :logging, :dump_errors, :raise_errors
  end
end
