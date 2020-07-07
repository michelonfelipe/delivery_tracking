# frozen_string_literal: true

require 'sinatra'
require 'dotenv/load' unless production?
require 'i18n'
require 'sinatra/activerecord'
require 'sinatra/flash'

require_relative './app/controllers/delivery_companies_controller.rb'
require_relative './app/controllers/notification_requests_controller.rb'
require_relative './app/controllers/reminders_controller.rb'
require_relative './app/exceptions/unprocessable_entity_error.rb'
require_relative './app/exceptions/resource_not_found_error.rb'

set :database_file, './config/database.yml'
set :views, settings.root + '/app/views'

enable :sessions

I18n.load_path << Dir[File.expand_path('config/locales') + '/*.yml']
I18n.config.enforce_available_locales = false
I18n.default_locale = 'pt-BR'

FORM_CONTENT_TYPE = 'application/x-www-form-urlencoded'
JSON_CONTENT_TYPE = 'application/json'

get '/' do
  erb :'notification_requests/create',
      layout: :index,
      locals: {
        delivery_companies: DeliveryCompaniesController.index,
        form_errors: JSON.parse(flash[:errors] || '{}'),
        success: flash[:success]
      }
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

post '/reminders/update_notification_requests' do
  status 204
  RemindersController.new.update_notification_requests
end

post '/reminders/close_inactive_notification_requests' do
  status 204
  RemindersController.new.close_inactive_notification_requests
end

post '/notification_requests' do
  pass unless request.content_type == JSON_CONTENT_TYPE
  content_type :json

  begin
    status 204
    NotificationRequestController.new(params: parsed_request_body).create.to_json
  rescue UnprocessableEntityError => e
    status 422
    e.message
  end
end

post '/notification_requests' do
  pass unless request.content_type == FORM_CONTENT_TYPE
  begin
    status 204
    NotificationRequestController.new(params: params).create.to_json
    flash[:success] = true
    redirect '/'
  rescue UnprocessableEntityError => e
    flash[:errors] = e.message
    redirect '/'
  end
end

post '/notification_requests/:id/status' do
  controller_params = {
    'notification_request_id' => params['id'],
    'content' => parsed_request_body['content']
  }

  begin
    status 201
    NotificationRequestController
      .new(params: controller_params)
      .update_status
  rescue UnprocessableEntityError => e
    content_type :json
    status 422
    e.message
  end
end

def parsed_request_body
  JSON.parse(request.body.read)
end

helpers do
  def show_errors_for_field(errors, field_name)
    errors[field_name].join(',') if errors&.dig(field_name)
  end
end
