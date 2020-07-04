# frozen_string_literal: true

RSpec.describe '/' do
  context 'GET to /' do
    let(:subjet) { get '/' }

    it 'returns status 200' do
      expect(subjet.status).to eq 200
    end

    it 'displays a the plataform title' do
      expect(subjet.body).to include 'Notificador de Entregas'
    end
  end
end
