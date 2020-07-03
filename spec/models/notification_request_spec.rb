# frozen_string_literal: true

require_relative '../../app/models/notification_request'
require_relative '../factories/notification_request'

RSpec.describe NotificationRequest do
  context 'when the model is valid' do
    let(:subject) { build(:notification_request) }

    it 'is saved' do
      expect(subject.valid?).to eq true
    end

    it 'can be saved' do
      expect(subject.save).to eq true
    end
  end

  context 'when the model is not valid' do
    context 'because it has no tracking code' do
      let(:subject) { build(:notification_request, tracking_code: '') }

      it 'cannot be saved' do
        expect(subject.valid?).to eq false
      end
    end

    context 'because it has no email for contact' do
      let(:subject) { build(:notification_request, email_for_contact: '') }

      it 'cannot be saved' do
        expect(subject.valid?).to eq false
      end
    end

    context 'because it has an invalid email for contact' do
      let(:subject) { build(:notification_request, email_for_contact: 'abc') }

      it 'cannot be saved' do
        expect(subject.valid?).to eq false
      end
    end

    context 'because it has no delivery company' do
      let(:subject) { build(:notification_request, delivery_company: nil) }

      it 'cannot be saved' do
        expect(subject.valid?).to eq false
      end
    end

    context 'because it has no status' do
      let(:subject) { build(:notification_request, status: nil) }

      it 'cannot be saved' do
        expect(subject.valid?).to eq false
      end
    end
  end

  context 'when it has statuses' do
    let(:subject) { create(:notification_request) }

    before(:each) do
      create_list(:notification_request_status, 2, notification_request: subject)
    end

    it 'they are ordered by #created_at' do
      expect(subject.statuses.last.created_at).to be >= subject.statuses.first.created_at
    end
  end
end
