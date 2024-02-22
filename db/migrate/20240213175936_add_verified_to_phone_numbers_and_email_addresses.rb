# frozen_string_literal: true

class AddVerifiedToPhoneNumbersAndEmailAddresses < ActiveRecord::Migration[7.1]
  def change
    add_column :email_addresses,
               :verified,
               :boolean,
               default: false,
               null: false
    add_column :phone_numbers, :verified, :boolean, default: false, null: false
  end
end
