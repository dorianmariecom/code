class RemoveNameFromPrograms < ActiveRecord::Migration[8.0]
  def change
    remove_column :programs, :name
  end
end
