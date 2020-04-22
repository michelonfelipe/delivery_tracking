# frozen_string_literal: true

require_relative '../models/delivery_company.rb'
require_relative '../decorators/delivery_company_decorator.rb'
require_relative '../exceptions/unprocessable_entity_error.rb'
require_relative '../exceptions/resource_not_found_error.rb'

class DeliveryCompaniesController
  def self.index
    DeliveryCompany.all.map do |delivery_company|
      DeliveryCompanyDecorator.call(delivery_company)
    end
  end

  def self.create(raw_params)
    sanitized_params = creation_params(raw_params)
    delivery_company = DeliveryCompany.new(sanitized_params)

    raise UnprocessableEntityError, delivery_company.errors.to_json unless delivery_company.valid?

    delivery_company.save
    DeliveryCompanyDecorator.call(delivery_company)
  end

  def self.delete(id)
    delivery_company = DeliveryCompany.find_by(id: id)
    raise ResourceNotFoundError unless delivery_company

    delivery_company.destroy
  end

  def self.creation_params(params)
    { name: params['name'] }
  end

  private_class_method :creation_params
end
