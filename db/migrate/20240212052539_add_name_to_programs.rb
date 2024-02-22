# frozen_string_literal: true

class AddNameToPrograms < ActiveRecord::Migration[7.1]
  def change
    add_column :programs, :name, :string, default: "", null: false
  end
end
