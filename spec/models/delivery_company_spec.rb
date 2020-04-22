# frozen_string_literal: true

require_relative '../../app/models/delivery_company'
require_relative '../factories/delivery_company'

RSpec.describe DeliveryCompany do
  context 'when the model is valid' do
    let(:subjet) { build(:delivery_company) }

    it 'is saved' do
      expect(subjet.valid?).to eq true
    end

    it 'can be saved' do
      expect(subjet.save).to eq true
    end
  end

  context 'when the model is not valid' do
    context 'because it has no name' do
      let(:subjet) { build(:delivery_company, name: '') }

      it 'cannot be saved' do
        expect(subjet.valid?).to eq false
      end
    end

    context 'because it has a name that is already used' do
      let(:already_existing_record) { create(:delivery_company) }
      let(:subjet) { build(:delivery_company, name: already_existing_record.name) }

      it 'cannot be saved' do
        expect(subjet.valid?).to eq false
      end
    end
  end
end
