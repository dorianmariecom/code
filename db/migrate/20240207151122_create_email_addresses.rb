# frozen_string_literal: true

class CreateEmailAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :email_addresses do |t|
      t.references :user, null: false, foreign_key: true
      t.string :email_address

      t.timestamps
    end
  end
end
