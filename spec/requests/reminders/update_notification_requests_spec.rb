# frozen_string_literal: true

require_relative '../../factories/notification_request.rb'
require_relative '../../../app/models/notification_request.rb'
require_relative '../../../infra/sns/notification_request_update_publisher.rb'

RSpec.describe 'POST /reminders/update_notification_requests' do
  context 'when receiving a request to remind to update notification requests' do
    let(:request) { post '/reminders/update_notification_requests' }

    context 'and there are active notification requests' do
      before(:each) do
        allow_any_instance_of(NotificationRequestUpdatePublisher).to receive(:publish)
        create_list(:notification_request, 2, status: NotificationRequest::STATUSES[:DONE])
        create_list(
          :notification_request,
          active_notification_request_count,
          status: NotificationRequest::STATUSES[:ACTIVE]
        )
      end

      let(:active_notification_request_count) { 2 }

      it 'returns status 204' do
        expect(request.status).to eq 204
      end

      it 'call the notifier for each active notification request' do
        expect_any_instance_of(NotificationRequestUpdatePublisher)
          .to receive(:publish).exactly(active_notification_request_count).times

        request
      end
    end

    context 'and there are not active notification requests' do
      before(:each) do
        create_list(:notification_request, 2, status: NotificationRequest::STATUSES[:DONE])
      end

      it 'returns status 204' do
        expect(request.status).to eq 204
      end

      it 'does not call the notifier' do
        expect_any_instance_of(NotificationRequestUpdatePublisher)
          .not_to receive(:publish)

        request
      end
    end
  end
end
