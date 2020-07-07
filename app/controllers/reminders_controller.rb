# frozen_string_literal: true

require_relative '../models/notification_request.rb'
require_relative '../decorators/notification_request_decorator.rb'
require_relative '../helpers/notification_request_finisher.rb'
require_relative '../../infra/sns/notification_request_update_publisher'

class RemindersController
  def initialize(
    update_notificatier: NotificationRequestUpdatePublisher.new,
    notification_request_finisher: NotificationRequestFinisher.new
  )
    @update_notificatier = update_notificatier
    @notification_request_finisher = notification_request_finisher
  end

  def update_notification_requests
    NotificationRequest.includes(:delivery_company).active.each do |notification_request|
      @update_notificatier.publish(
        NotificationRequestDecorator.new(notification_request).with_delivery_company
      )
    end
  end

  def close_inactive_notification_requests
    NotificationRequest.inactive.each do |notification_request|
      @notification_request_finisher.finish(notification_request)
    end
  end
end
