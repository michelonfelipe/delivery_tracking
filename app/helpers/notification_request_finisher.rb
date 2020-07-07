# frozen_string_literal: true

require_relative '../../infra/email/finish_notification_request_email_sender.rb'

class NotificationRequestFinisher
  def initialize(
    finisher_email_sender_class: FinishNotificationRequestEmailSender
  )
    @finisher_email_sender_class = finisher_email_sender_class
  end

  def finish(notification_request)
    ActiveRecord::Base.transaction do
      notification_request.status = NotificationRequest::STATUSES[:DONE]
      notification_request.save!
      @finisher_email_sender_class.new(
        to: notification_request.email_for_contact,
        tracking_code: notification_request.tracking_code
      ).send
    end
  end
end
