# frozen_string_literal: true

class NotificationRequestDecorator
  def self.call(notification_request)
    {
      id: notification_request.id,
      tracking_code: notification_request.tracking_code,
      email_for_contact: notification_request.email_for_contact
    }
  end
end
