# frozen_string_literal: true

require 'sinatra'
require 'dotenv/load'
require 'sinatra/activerecord'

require_relative './app/controllers/delivery_companies_controller.rb'
require_relative './app/exceptions/unprocessable_entity_error.rb'

set :database_file, './config/database.yml'

get '/' do
  'Hello world!'
end

get '/delivery_companies' do
  status 200
  content_type :json
  DeliveryCompaniesController.index.to_json
end

post '/delivery_companies' do
  content_type :json

  begin
    status 201
    DeliveryCompaniesController.create(raw_params).to_json
  rescue UnprocessableEntityError => e
    status 422
    e.message
  end
end

def raw_params
  JSON.parse(request.body.read)
end
