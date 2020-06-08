# frozen_string_literal: true

class CreateNotificationRequestStatus < ActiveRecord::Migration[6.0]
  def change
    create_table :notification_request_statuses do |t|
      t.text :content
      t.references :notification_request

      t.timestamps
    end
  end
end
