# frozen_string_literal: true

require 'factory_bot'
require_relative './notification_request'

FactoryBot.define do
  factory :notification_request_status do
    content { 'content' }

    association :notification_request, strategy: :create
  end
end
