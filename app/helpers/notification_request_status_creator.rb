# frozen_string_literal: true

require_relative '../../infra/email/update_on_notification_request_email_sender.rb'

class NotificationRequestStatusCreator
  def initialize(notification_request_status)
    @notification_request_status = notification_request_status
  end

  def create!
    return if last_notification_request_status_content == @notification_request_status.content

    ActiveRecord::Base.transaction do
      @notification_request_status.save!
      UpdateOnNotificationRequestEmailSender.new(
        to: @notification_request_status.notification_request.email_for_contact,
        tracking_code: @notification_request_status.notification_request.tracking_code
      ).send
    end
  end

  private

  def last_notification_request_status_content
    @last_notification_request_status_content ||=
      @notification_request_status
      .notification_request
      .statuses
      .last
      &.content
  end
end
