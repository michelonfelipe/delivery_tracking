# frozen_string_literal: true

require_relative '../../factories/notification_request.rb'
require_relative '../../../app/models/notification_request.rb'

RSpec.describe 'POST /notification_requests/:id/status' do
  context 'given a POST request to /notification_requests/:id/status' do
    let(:request) do
      post "/notification_requests/#{notification_request_id}/status",
           request_body.to_json,
           'SHARED-SECRET' => ENV['SHARED_SECRET']
    end

    context 'when the id on the url is valid' do
      let(:notification_request) { create(:notification_request) }
      let(:notification_request_id) { notification_request.id }

      context 'and the request body is valid' do
        let(:request_body) { { content: 'new status' } }

        context 'and the update email is sent sucesfully' do
          before(:each) do
            allow_any_instance_of(UpdateOnNotificationRequestEmailSender)
              .to receive(:send)
          end

          it 'returns status 201' do
            expect(request.status).to eq(201)
          end

          it 'saves the entity on the database' do
            notification_request_statuses_count = notification_request.statuses.length
            request
            expect(
              notification_request.reload.statuses.length
            ).to eq(notification_request_statuses_count + 1)
          end
        end

        context 'and the update email is not sent' do
          before(:each) do
            allow_any_instance_of(NotificationRequestStatusCreator)
              .to receive(:create!)
              .and_raise(StandardError.new('cant send email'))
          end

          it 'raises an error' do
            expect { request }.to raise_error(StandardError, 'cant send email')
          end
        end
      end

      context 'and the request body is invalid' do
        let(:parsed_response) { JSON.parse(request.body) }

        context 'because there is no content' do
          let(:request_body) { { content: nil } }

          it 'returns status 422' do
            expect(request.status).to eq(422)
          end

          it 'returns the errors' do
            expect(parsed_response).to include 'content'
          end
        end
      end
    end

    context 'when the id on the url is not valid' do
      let(:notification_request_id) { '123' }
      let(:request_body) { { content: 'new status' } }
      let(:parsed_response) { JSON.parse(request.body) }

      it 'returns status 422' do
        expect(request.status).to eq(422)
      end

      it 'returns the errors' do
        expect(parsed_response).to include 'notification_request'
      end
    end
  end
end
