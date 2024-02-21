# frozen_string_literal: true

class AddDisplayNameToEmailAddresses < ActiveRecord::Migration[7.1]
  def change
    add_column :email_addresses, :display_name, :string
  end
end
