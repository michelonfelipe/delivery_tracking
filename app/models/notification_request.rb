# frozen_string_literal: true

require_relative './notification_request_status'

class NotificationRequest < ActiveRecord::Base
  STATUSES = {
    ACTIVE: 'active',
    DONE: 'done'
  }.freeze

  attribute :status, default: STATUSES[:ACTIVE]

  validates :status, presence: true
  validates :tracking_code, presence: true
  validates :email_for_contact, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  belongs_to :delivery_company, optional: false

  has_many :statuses,
           -> { order('created_at') },
           dependent: :destroy,
           class_name: 'NotificationRequestStatus'

  scope :active, -> { where(status: STATUSES[:ACTIVE]) }
end
