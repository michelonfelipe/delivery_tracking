# frozen_string_literal: true

require 'aws-sdk-sns'
require 'json'
require_relative '../../../infra/sns/notification_request_update_publisher'

# TODO: Remove logs when running tests
RSpec.describe NotificationRequestUpdatePublisher do
  context 'when there is a message' do
    let(:message) { 'message' }
    let(:arn) { ENV['NOTIFICATION_REQUEST_UPDATE_PUBLISHER_ARN'] }
    let(:expected_return) { { message_id: 1 } }
    let(:published_message) { { message: JSON.generate(message) } }
    let(:subject) { described_class.new(client: double_client) }
    let(:double_client) { instance_double('Aws::SNS::Resource') }
    let(:double_topic) { instance_double('Aws::SNS::Topic') }

    before(:each) do
      allow(double_client).to receive(:topic).with(arn).and_return(double_topic)
      allow(double_topic).to receive(:publish).with(published_message).and_return(expected_return)
    end

    it 'sends the message' do
      subject.publish(message)
      expect(double_topic).to have_received(:publish).with(published_message)
    end

    it 'returns the message id' do
      expect(subject.publish(message)).to eq(expected_return)
    end
  end
end
