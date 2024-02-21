# frozen_string_literal: true

class CreatePasswords < ActiveRecord::Migration[7.1]
  def change
    create_table :passwords do |t|
      t.references :user, null: false, foreign_key: true
      t.string :password_digest

      t.timestamps
    end
  end
end
