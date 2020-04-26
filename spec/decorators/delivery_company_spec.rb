# frozen_string_literal: true

require_relative '../../app/decorators/delivery_company_decorator'
require_relative '../factories/delivery_company'

RSpec.describe DeliveryCompanyDecorator do
  context 'given a DeliveryCompany instance' do
    let(:delivery_company) { build(:delivery_company) }

    it 'decorates the model' do
      expected_result = { id: delivery_company.id, name: delivery_company.name }
      expect(described_class.call(delivery_company)).to eq expected_result
    end
  end
end
