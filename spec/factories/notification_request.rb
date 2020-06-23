# frozen_string_literal: true

require 'factory_bot'
require_relative './delivery_company'
require_relative '../../app/models/notification_request'

FactoryBot.define do
  factory :notification_request do
    tracking_code { '123' }
    email_for_contact { 'contact@mail.com' }
    status { NotificationRequest::STATUSES[:ACTIVE] }

    association :delivery_company, strategy: :create
  end
end
