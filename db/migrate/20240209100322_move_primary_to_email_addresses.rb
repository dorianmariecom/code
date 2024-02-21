# frozen_string_literal: true

class MovePrimaryToEmailAddresses < ActiveRecord::Migration[7.1]
  def change
    remove_reference :users, :primary_email_address

    add_column :email_addresses, :primary, :boolean, default: false, null: false
  end
end
