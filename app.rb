# frozen_string_literal: true

require 'sinatra'
require 'dotenv/load'
require 'sinatra/activerecord'

require_relative './app/controllers/delivery_companies_controller.rb'

set :database_file, './config/database.yml'

get '/' do
  'Hello world!'
end

get '/delivery_companies' do
  status 200
  content_type :json
  DeliveryCompaniesController.index.to_json
end
