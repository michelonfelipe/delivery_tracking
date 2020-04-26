# frozen_string_literal: true

require_relative '../models/notification_request.rb'
require_relative '../decorators/notification_request_decorator.rb'
require_relative '../exceptions/unprocessable_entity_error.rb'
require_relative '../exceptions/resource_not_found_error.rb'

class NotificationRequestController
  def self.create(raw_params)
    sanitized_params = creation_params(raw_params)
    notification_request = NotificationRequest.new(sanitized_params)

    unless notification_request.valid?
      raise UnprocessableEntityError, notification_request.errors.to_json
    end

    notification_request.save
    NotificationRequestDecorator.call(notification_request)
  end

  def self.creation_params(params)
    {
      tracking_code: params['tracking_code'],
      email_for_contact: params['email_for_contact'],
      delivery_company_id: params['delivery_company_id']
    }
  end

  private_class_method :creation_params
end
