class ConsolidateIntervalForSchedules < ActiveRecord::Migration[8.0]
  def change
    remove_column :schedules, :count
    remove_column :schedules, :per
    add_column :schedules, :interval, :string
  end
end
