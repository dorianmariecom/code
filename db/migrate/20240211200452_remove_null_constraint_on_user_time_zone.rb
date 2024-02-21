# frozen_string_literal: true

class RemoveNullConstraintOnUserTimeZone < ActiveRecord::Migration[7.1]
  def change
    change_column_null :users, :time_zone, true
  end
end
