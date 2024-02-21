# frozen_string_literal: true

class ChangeDefaultTimeZoneForUsers < ActiveRecord::Migration[7.1]
  def change
    change_column_default :users, :time_zone, nil
  end
end
