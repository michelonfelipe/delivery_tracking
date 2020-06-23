# frozen_string_literal: true

class NotificationRequestDecorator
  # TODO: Turn class methods on instance methods
  def self.call(notification_request)
    {
      id: notification_request.id,
      tracking_code: notification_request.tracking_code,
      email_for_contact: notification_request.email_for_contact
    }
  end

  def initialize(notification_request)
    @notification_request = notification_request
  end

  def with_delivery_company
    {
      id: @notification_request.id,
      tracking_code: @notification_request.tracking_code,
      email_for_contact: @notification_request.email_for_contact,
      delivery_company: {
        name: @notification_request.delivery_company.name
      }
    }
  end
end
