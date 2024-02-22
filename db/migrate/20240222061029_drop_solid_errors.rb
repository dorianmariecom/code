class DropSolidErrors < ActiveRecord::Migration[7.2]
  def change
    drop_table :solid_errors_occurrences
    drop_table :solid_errors
  end
end
