# frozen_string_literal: true

require_relative './notification_request_status'

class NotificationRequest < ActiveRecord::Base
  validates :tracking_code, presence: true
  validates :email_for_contact, presence: true

  belongs_to :delivery_company, optional: false

  has_many :statuses,
           -> { order('created_at') },
           dependent: :destroy,
           class_name: 'NotificationRequestStatus'
end
