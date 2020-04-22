# frozen_string_literal: true

require 'sinatra'
require 'dotenv/load'
require 'sinatra/activerecord'

require_relative './app/controllers/delivery_companies_controller.rb'
require_relative './app/exceptions/unprocessable_entity_error.rb'
require_relative './app/exceptions/resource_not_found_error.rb'

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
    DeliveryCompaniesController.create(parsed_request_body).to_json
  rescue UnprocessableEntityError => e
    status 422
    e.message
  end
end

delete '/delivery_companies/:id' do
  begin
    status 204
    DeliveryCompaniesController.delete(params['id'])
  rescue ResourceNotFoundError
    status 404
  end
end

def parsed_request_body
  JSON.parse(request.body.read)
end
