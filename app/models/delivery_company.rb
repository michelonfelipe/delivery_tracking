# frozen_string_literal: true

class DeliveryCompany < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
end
