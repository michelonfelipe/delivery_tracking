# frozen_string_literal: true

require_relative '../../app/models/notification_request_status'
require_relative '../factories/notification_request_status'

RSpec.describe NotificationRequestStatus do
  context 'when the model is valid' do
    let(:subject) { build(:notification_request_status) }

    it 'is saved' do
      expect(subject.valid?).to eq true
    end

    it 'can be saved' do
      expect(subject.save).to eq true
    end
  end

  context 'when the model is not valid' do
    context 'because it has no content' do
      let(:subject) { build(:notification_request_status, content: '') }

      it 'cannot be saved' do
        expect(subject.valid?).to eq false
      end
    end

    context 'because it has no notification request' do
      let(:subject) { build(:notification_request_status, notification_request: nil) }

      it 'cannot be saved' do
        expect(subject.valid?).to eq false
      end
    end
  end
end
