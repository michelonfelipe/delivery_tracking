# frozen_string_literal: true

class AddStatusToNotificationRequests < ActiveRecord::Migration[6.0]
  def change
    add_column :notification_requests, :status, :string
    add_index :notification_requests, :status
  end
end
