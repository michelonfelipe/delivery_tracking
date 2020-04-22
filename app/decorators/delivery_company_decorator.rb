# frozen_string_literal: true

class DeliveryCompanyDecorator
  def self.call(delivery_company)
    {
      id: delivery_company.id,
      name: delivery_company.name
    }
  end
end
