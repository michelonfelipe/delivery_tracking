# frozen_string_literal: true

RSpec.describe '/delivery_companies' do
  context 'given a GET request to /delivery_companies' do
    let(:subjet) { get '/delivery_companies' }

    context 'when there are delivery companies' do
      let!(:delivery_company) { create(:delivery_company) }
      let(:parsed_response) { JSON.parse(subjet.body) }

      it 'returns status 200' do
        expect(subjet.status).to eq 200
      end

      it 'returns an array with all delivery companies' do
        expect(parsed_response.length).to eq 1
      end

      it 'returns an array the delivery companies main attributes' do
        expect(parsed_response[0]).to include 'id'
        expect(parsed_response[0]).to include 'name'

        expect(parsed_response.dig(0, 'id')).to eq delivery_company.id
        expect(parsed_response.dig(0, 'name')).to eq delivery_company.name
      end
    end

    context 'when there are no delivery companies' do
      let(:parsed_response) { JSON.parse(subjet.body) }

      it 'returns status 200' do
        expect(subjet.status).to eq 200
      end

      it 'returns an empty array ' do
        expect(parsed_response.length).to eq 0
      end
    end
  end
end
