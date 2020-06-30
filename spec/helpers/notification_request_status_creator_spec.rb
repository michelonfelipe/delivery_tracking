# frozen_string_literal: true

require_relative '../../app/helpers/notification_request_status_creator.rb'
require_relative '../factories/notification_request_status'

RSpec.describe NotificationRequestStatusCreator do
  context 'when its needed to create a NotificationRequestStatus' do
    let(:result) { described_class.new(notification_request_status) }

    context 'and there is no other NotificationRequestStatus with that content' do
      context 'and it is a valid model' do
        let(:notification_request_status) { build(:notification_request_status) }

        context 'and the email is sent sucesfully' do
          before(:each) do
            allow_any_instance_of(UpdateOnNotificationRequestEmailSender).to receive(:send)
          end

          it 'save the NotificationRequestStatus ' do
            expect { result.create! }.to change { NotificationRequestStatus.count }.by(1)
          end

          it 'save the NotificationRequestStatus ' do
            expect_any_instance_of(UpdateOnNotificationRequestEmailSender)
              .to receive(:send).exactly(1).time

            result.create!
          end
        end

        context 'and there is a problem sending the email' do
          before(:each) do
            allow_any_instance_of(UpdateOnNotificationRequestEmailSender)
              .to receive(:send)
              .and_raise(StandardError.new('problem sending the email'))
          end

          it 'raises an error' do
            expect { result.create! }.to raise_error(StandardError, 'problem sending the email')
          end
        end
      end

      context 'and it is not a valid model' do
        let(:notification_request_status) { build(:notification_request_status, content: '') }

        it 'raises an error' do
          expect { result.create! }.to raise_error(ActiveRecord::RecordInvalid)
        end
      end
    end

    context 'and there is other NotificationRequestStatus, with that content' do
      let(:notification_request_status) { build(:notification_request_status) }
      before(:each) do
        create(
          :notification_request_status,
          notification_request: notification_request_status.notification_request,
          content: notification_request_status.content
        )
      end

      it 'does not save the NotificationRequestStatus' do
        expect { result.create! }.to_not change { NotificationRequestStatus.count }
      end
    end
  end
end
