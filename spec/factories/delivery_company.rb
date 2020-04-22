# frozen_string_literal: true

require 'factory_bot'

FactoryBot.define do
  factory :delivery_company do
    sequence :name do |n|
      "company #{n}"
    end
  end
end
