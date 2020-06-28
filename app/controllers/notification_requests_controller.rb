# frozen_string_literal: true

require_relative '../models/notification_request.rb'
require_relative '../decorators/notification_request_decorator.rb'
require_relative '../exceptions/unprocessable_entity_error.rb'
require_relative '../exceptions/resource_not_found_error.rb'

class NotificationRequestController
  def initialize(params:)
    @params = params
  end

  def create
    notification_request = NotificationRequest.new(creation_params)
    unless notification_request.valid?
      raise UnprocessableEntityError, notification_request.errors.to_json
    end

    notification_request.save
    NotificationRequestDecorator.call(notification_request)
  end

  def update_status
    notification_request_status = NotificationRequestStatus.new(update_status_params)
    unless notification_request_status.valid?
      raise UnprocessableEntityError, notification_request_status.errors.to_json
    end

    notification_request_status.save
  end

  private

  def creation_params
    {
      tracking_code: @params['tracking_code'],
      email_for_contact: @params['email_for_contact'],
      delivery_company_id: @params['delivery_company_id']
    }
  end

  def update_status_params
    @update_status_params ||= {
      notification_request_id: @params['notification_request_id'],
      content: @params['content']
    }
  end
end
