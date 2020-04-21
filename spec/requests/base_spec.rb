# frozen_string_literal: true

RSpec.describe '/' do
  context 'GET to /' do
    let(:subjet) { get '/' }

    it 'returns status 200' do
      expect(subjet.status).to eq 200
    end

    it 'displays a friendly message' do
      expect(subjet.body).to include 'Hello world!'
    end
  end
end
