# frozen_string_literal: true

class AddHintToPasswords < ActiveRecord::Migration[7.1]
  def change
    add_column :passwords, :hint, :string, default: '', null: false
  end
end
