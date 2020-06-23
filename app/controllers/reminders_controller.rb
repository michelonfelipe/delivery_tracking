# frozen_string_literal: true

require_relative '../models/notification_request.rb'
require_relative '../decorators/notification_request_decorator.rb'
require_relative '../../infra/sns/notification_request_created_publisher'

class RemindersController
  def initialize(
    update_notificatier: NotificationRequestUpdatePublisher.new
  )
    @update_notificatier = update_notificatier
  end

  def update_notification_requests
    NotificationRequest.includes(:delivery_company).active.each do |notification_request|
      @update_notificatier.publish(
        NotificationRequestDecorator.new(notification_request).with_delivery_company
      )
    end
  end
end
