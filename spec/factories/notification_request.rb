# frozen_string_literal: true

require 'factory_bot'
require_relative './delivery_company'

FactoryBot.define do
  factory :notification_request do
    tracking_code { '123' }
    email_for_contact { 'contact@mail.com' }

    association :delivery_company, strategy: :create
  end
end
