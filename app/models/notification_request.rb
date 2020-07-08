# frozen_string_literal: true

require 'date'

require_relative './notification_request_status'

class NotificationRequest < ActiveRecord::Base
  DAYS_TO_BE_CONSIDERED_INACTIVE = 5
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
  scope :inactive, lambda {
    find_by_sql(
      [
        "
          SELECT *
          FROM notification_requests
          WHERE id IN(
            SELECT distinct on (notification_request_id) notification_request_id
            FROM notification_request_statuses
            WHERE created_at <= ?
            ORDER BY notification_request_id, created_at
          ) AND status = ?
        ",
        DateTime.now - NotificationRequest::DAYS_TO_BE_CONSIDERED_INACTIVE,
        STATUSES[:ACTIVE]
      ]
    )
  }
end
