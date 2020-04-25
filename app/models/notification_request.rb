# frozen_string_literal: true

class NotificationRequest < ActiveRecord::Base
  validates :tracking_code, presence: true
  validates :email_for_contact, presence: true

  belongs_to :delivery_company, optional: false
end
