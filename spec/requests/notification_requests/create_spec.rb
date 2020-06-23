# frozen_string_literal: true

require_relative '../../factories/delivery_company.rb'
require_relative '../../../app/models/delivery_company.rb'

RSpec.describe 'POST /notification_requests' do
  context 'given a POST request to /notification_requests' do
    let(:request) { post '/notification_requests', request_body.to_json }

    context 'when the request body is valid' do
      let!(:notification_requests_count_before_request) { NotificationRequest.count }
      let(:request_body) do
        {
          tracking_code: 'code 123',
          email_for_contact: 'test@mail.com',
          delivery_company_id: create(:delivery_company).id
        }
      end

      before(:each) do
        allow_any_instance_of(NotificationRequestCreatedPublisher).to receive(:publish)
      end

      it 'returns status 204' do
        expect(request.status).to eq 204
      end

      it 'saves the entity on the database' do
        request
        expect(NotificationRequest.count).to eq notification_requests_count_before_request + 1
      end
    end

    context 'when the request body is invalid' do
      let(:parsed_response) { JSON.parse(request.body) }

      context 'because there is no tracking code' do
        let(:request_body) do
          {
            tracking_code: '',
            email_for_contact: 'test@mail.com',
            delivery_company_id: create(:delivery_company).id
          }
        end

        it 'returns status 422' do
          expect(request.status).to eq 422
        end

        it 'returns the errors' do
          expect(parsed_response).to include 'tracking_code'
        end
      end

      context 'because there is no email for contact' do
        let(:request_body) do
          {
            tracking_code: 'code 123',
            email_for_contact: '',
            delivery_company_id: create(:delivery_company).id
          }
        end

        it 'returns status 422' do
          expect(request.status).to eq 422
        end

        it 'returns the errors' do
          expect(parsed_response).to include 'email_for_contact'
        end
      end

      context 'because there is no delivery company id' do
        let(:request_body) do
          {
            tracking_code: 'code 123',
            email_for_contact: 'test@mail.com',
            delivery_company_id: ''
          }
        end

        it 'returns status 422' do
          expect(request.status).to eq 422
        end

        it 'returns the errors' do
          expect(parsed_response).to include 'delivery_company'
        end
      end
    end
  end
end
