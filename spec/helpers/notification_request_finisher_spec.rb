# frozen_string_literal: true

require_relative '../../app/helpers/notification_request_finisher.rb'

RSpec.describe NotificationRequestFinisher do
  context 'when its needed to finish a NotificationRequest' do
    let(:result) { described_class.new }
    let(:notification_request) { double(NotificationRequest) }

    context 'and there is no problem saving it after setting it to done' do
      before(:each) do
        allow(notification_request).to receive(:status=)
        allow(notification_request).to receive(:save!)
        allow(notification_request).to receive(:email_for_contact)
        allow(notification_request).to receive(:tracking_code)
      end

      context 'and the email is sent sucesfully' do
        before(:each) do
          allow_any_instance_of(FinishNotificationRequestEmailSender).to receive(:send)
        end

        it 'sets the notification request as done' do
          expect(notification_request)
            .to receive(:status=)
            .with(NotificationRequest::STATUSES[:DONE])
            .exactly(1).time

          subject.finish(notification_request)
        end

        it 'saves the notification request' do
          expect(notification_request)
            .to receive(:save!)
            .exactly(1).time

          subject.finish(notification_request)
        end

        it 'sends an email' do
          expect_any_instance_of(FinishNotificationRequestEmailSender)
            .to receive(:send)
            .exactly(1).time

          subject.finish(notification_request)
        end
      end

      context 'and there is a problem sending the email' do
        before(:each) do
          allow_any_instance_of(FinishNotificationRequestEmailSender)
            .to receive(:send)
            .and_raise(StandardError.new('problem sending the email'))
        end

        it 'raises an error' do
          expect do
            subject.finish(notification_request)
          end.to raise_error(StandardError, 'problem sending the email')
        end
      end
    end

    context 'and there is a problem saving it after setting it to done' do
      before(:each) do
        allow(notification_request).to receive(:status=)
        allow(notification_request)
          .to receive(:save!)
          .and_raise(StandardError.new('problem on saving'))
      end

      it 'raises an error' do
        expect do
          subject.finish(notification_request)
        end.to raise_error(StandardError, 'problem on saving')
      end
    end
  end
end
