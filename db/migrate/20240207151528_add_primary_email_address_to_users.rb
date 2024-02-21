# frozen_string_literal: true

class AddPrimaryEmailAddressToUsers < ActiveRecord::Migration[7.1]
  def change
    add_reference(
      :users,
      :primary_email_address,
      foreign_key: { to_table: :email_addresses }
    )
  end
end
