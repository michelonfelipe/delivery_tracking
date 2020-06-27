# frozen_string_literal: true

require_relative '../models/notification_request.rb'
require_relative '../decorators/notification_request_decorator.rb'
require_relative '../exceptions/unprocessable_entity_error.rb'
require_relative '../exceptions/resource_not_found_error.rb'
require_relative '../../infra/sns/notification_request_created_publisher'

class NotificationRequestController
  def initialize(
    params:,
    notification_request_created_publisher: NotificationRequestCreatedPublisher.new
  )
    @params = params
    @notification_request_created_publisher = notification_request_created_publisher
  end

  def create
    notification_request = NotificationRequest.new(creation_params)
    unless notification_request.valid?
      raise UnprocessableEntityError, notification_request.errors.to_json
    end

    # TODO: Create transaction, so if any error occur, the entity will not be saved
    notification_request.save
    decorated_entity = NotificationRequestDecorator.call(notification_request)
    @notification_request_created_publisher.publish(decorated_entity)
    decorated_entity
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
