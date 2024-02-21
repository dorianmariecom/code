# frozen_string_literal: true

class CreatePhoneNumbers < ActiveRecord::Migration[7.1]
  def change
    create_table :phone_numbers do |t|
      t.references :user, null: false, foreign_key: true
      t.boolean :primary, default: false, null: false
      t.string :phone_number, null: false

      t.timestamps
    end
  end
end
