class RenameAtToStartsAt < ActiveRecord::Migration[8.0]
  def change
    rename_column :schedules, :at, :starts_at
  end
end
