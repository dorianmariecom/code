class MoveLatitudeAndLongitudeToStrings < ActiveRecord::Migration[7.2]
  def change
    remove_column :users, :latitude
    remove_column :users, :longitude
    add_column :users, :latitude, :string, default: "", null: false
    add_column :users, :longitude, :string, default: "", null: false
  end
end
