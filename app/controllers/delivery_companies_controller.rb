# frozen_string_literal: true

require_relative '../models/delivery_company.rb'
require_relative '../decorators/delivery_company_decorator.rb'

class DeliveryCompaniesController
  def self.index
    DeliveryCompany.all.map do |delivery_company|
      DeliveryCompanyDecorator.call(delivery_company)
    end
  end
end
