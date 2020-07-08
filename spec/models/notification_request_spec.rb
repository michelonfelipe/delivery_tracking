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

  context 'when it is active' do
    before(:each) do
      create_list(:notification_request, 2, status: NotificationRequest::STATUSES[:ACTIVE])
      create_list(:notification_request, 2, status: NotificationRequest::STATUSES[:DONE])
    end

    it 'retrieves only the active ones' do
      expect(NotificationRequest.active.count).to eq(2)
    end
  end

  context 'when it is inactive' do
    before(:each) do
      create_list(
        :notification_request, 1, status: NotificationRequest::STATUSES[:ACTIVE]
      ).each do |nr|
        create(
          :notification_request_status, notification_request: nr, created_at: DateTime.now
        )
      end

      create_list(
        :notification_request, 2, status: NotificationRequest::STATUSES[:ACTIVE]
      ).each do |nr|
        create(
          :notification_request_status,
          notification_request: nr,
          created_at: DateTime.now - NotificationRequest::DAYS_TO_BE_CONSIDERED_INACTIVE
        )
      end

      create_list(
        :notification_request, 3, status: NotificationRequest::STATUSES[:DONE]
      ).each do |nr|
        create(
          :notification_request_status, notification_request: nr, created_at: DateTime.now
        )
      end

      create_list(
        :notification_request, 4, status: NotificationRequest::STATUSES[:DONE]
      ).each do |nr|
        create(
          :notification_request_status,
          notification_request: nr,
          created_at: DateTime.now - NotificationRequest::DAYS_TO_BE_CONSIDERED_INACTIVE
        )
      end
    end

    it 'retrieves only the active ones' do
      expect(NotificationRequest.inactive.count).to eq(2)
    end
  end
end
