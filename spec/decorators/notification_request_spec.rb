# frozen_string_literal: true

require_relative '../../app/decorators/notification_request_decorator'
require_relative '../factories/notification_request'

RSpec.describe NotificationRequestDecorator do
  context 'given a NotificationRequest instance' do
    let(:notification_request) { build(:notification_request) }

    it 'decorates the model' do
      expected_result = {
        id: notification_request.id,
        tracking_code: notification_request.tracking_code,
        email_for_contact: notification_request.email_for_contact
      }
      expect(described_class.call(notification_request)).to eq expected_result
    end
  end
end
