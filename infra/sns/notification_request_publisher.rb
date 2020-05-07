# frozen_string_literal: true

require 'aws-sdk-sns'
require 'json'

class NotificationRequestPublisher
  def initialize(client: Aws::SNS::Resource.new)
    @client = client
  end

  def publish(raw_message)
    topic = @client.topic(ENV['NOTIFICATION_REQUEST_PUBLISHER_ARN'])
    enconded_message = JSON.generate(raw_message)
    puts "[#{self.class}] sending message #{enconded_message}"
    topic.publish({ message: enconded_message })
  end
end
