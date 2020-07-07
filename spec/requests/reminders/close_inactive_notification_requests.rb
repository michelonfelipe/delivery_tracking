# frozen_string_literal: true

require_relative '../../factories/notification_request.rb'
require_relative '../../factories/notification_request_status.rb'
require_relative '../../../app/models/notification_request.rb'
require_relative '../../../app/helpers/notification_request_finisher.rb'

RSpec.describe 'POST /reminders/update_notification_requests' do
  context 'when receiving a request to remind to update notification requests' do
    let(:request) { post '/reminders/close_inactive_notification_requests' }

    context 'and there are inactive notification requests' do
      before(:each) do
        allow_any_instance_of(NotificationRequestFinisher).to receive(:finish)

        nr = create(:notification_request, status: NotificationRequest::STATUSES[:ACTIVE])
        create(
          :notification_request_status,
          notification_request: nr,
          created_at: DateTime.now - NotificationRequest::DAYS_TO_BE_CONSIDERED_INACTIVE
        )
      end

      it 'returns status 204' do
        expect(request.status).to eq 204
      end

      it 'call the finisher for each inactive notification request' do
        expect_any_instance_of(NotificationRequestFinisher)
          .to receive(:finish).exactly(1).time

        request
      end
    end

    context 'and there are no inactive notification requests' do
      before(:each) do
        nr = create(:notification_request, status: NotificationRequest::STATUSES[:ACTIVE])
        create(:notification_request_status, notification_request: nr)
      end

      it 'returns status 204' do
        expect(request.status).to eq 204
      end

      it 'does not call the notifier' do
        expect_any_instance_of(NotificationRequestFinisher)
          .not_to receive(:finish)

        request
      end
    end
  end
end
