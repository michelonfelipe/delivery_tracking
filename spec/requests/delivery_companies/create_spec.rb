# frozen_string_literal: true

require_relative '../../../app/models/delivery_company.rb'
require_relative '../../factories/delivery_company.rb'

RSpec.describe 'POST /delivery_companies' do
  context 'given a POST request to /delivery_companies' do
    let(:request) do
      post '/delivery_companies',
           request_body.to_json,
           'SHARED-SECRET' => ENV['SHARED_SECRET']
    end

    context 'when the request body is valid' do
      let(:request_body) { { name: 'company name' } }

      context 'and there is no delivery company with that name' do
        let(:parsed_response) { JSON.parse(request.body) }
        let!(:delivery_companies_count_before_request) { DeliveryCompany.count }

        it 'returns status 201' do
          expect(request.status).to eq 201
        end

        it 'returns the created entity data' do
          expect(parsed_response).to include 'id'
          expect(parsed_response).to include 'name'
          expect(parsed_response['name']).to eq request_body[:name]
        end

        it 'saves the entity on the database' do
          request
          expect(DeliveryCompany.count).to eq delivery_companies_count_before_request + 1
        end
      end

      context 'and there is a delivery company with that name' do
        let!(:delivery_company) { create(:delivery_company, name: request_body[:name]) }
        let!(:delivery_companies_count_before_request) { DeliveryCompany.count }
        let(:parsed_response) { JSON.parse(request.body) }

        it 'returns status 422' do
          expect(request.status).to eq 422
        end

        it 'returns the errors' do
          expect(parsed_response).to include 'name'
        end

        it 'does not save the entity on the database' do
          request
          expect(DeliveryCompany.count).to eq delivery_companies_count_before_request
        end
      end
    end
  end
end
