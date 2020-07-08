# frozen_string_literal: true

require_relative '../../factories/delivery_company.rb'

require_relative '../../../app/models/delivery_company.rb'

RSpec.describe 'DELETE /delivery_companies/:id' do
  context 'given a DELETE request to /delivery_companies/:id' do
    let(:request) do
      delete "/delivery_companies/#{delivery_company.id}",
             nil,
             'SHARED-SECRET' => ENV['SHARED_SECRET']
    end

    context 'when the entity exists' do
      let!(:delivery_company) { create(:delivery_company) }

      it 'returns status 204' do
        expect(request.status).to eq 204
      end

      it 'deletes the entity on the database' do
        delivery_companies_count_before_request = DeliveryCompany.count
        request
        expect(DeliveryCompany.count).to eq delivery_companies_count_before_request - 1
      end
    end

    context 'when the entity does not exist' do
      let(:delivery_company) { OpenStruct.new(id: 123) }

      it 'returns status 404' do
        expect(request.status).to eq 404
      end

      it 'deletes nothing from database' do
        delivery_companies_count_before_request = DeliveryCompany.count
        request
        expect(DeliveryCompany.count).to eq delivery_companies_count_before_request
      end
    end
  end
end
