# frozen_string_literal: true

require 'sinatra'
require 'dotenv/load'
require 'sinatra/activerecord'

set :database_file, './config/database.yml'

get '/' do
  'Hello world!'
end
