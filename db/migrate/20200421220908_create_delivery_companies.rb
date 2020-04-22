# frozen_string_literal: true

class CreateDeliveryCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :delivery_companies do |t|
      t.string :name

      t.timestamps
    end
  end
end
