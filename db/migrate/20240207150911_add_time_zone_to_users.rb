# frozen_string_literal: true

class AddTimeZoneToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :time_zone, :string, default: "", null: false
  end
end
