class StartsAtIsDatetimeNotTime < ActiveRecord::Migration[8.0]
  def change
    remove_column :schedules, :starts_at
    add_column :schedules, :starts_at, :datetime
  end
end
