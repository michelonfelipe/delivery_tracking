# frozen_string_literal: true

class NotificationRequestStatus < ActiveRecord::Base
  validates :content, presence: true

  belongs_to :notification_request, optional: false
end
