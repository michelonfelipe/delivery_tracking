# frozen_string_literal: true

class CreateNotificationRequest < ActiveRecord::Migration[6.0]
  def change
    create_table :notification_requests do |t|
      t.string :tracking_code
      t.references :delivery_company
      t.string :email_for_contact

      t.timestamps
    end
  end
end
