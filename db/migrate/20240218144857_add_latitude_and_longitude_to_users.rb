class AddLatitudeAndLongitudeToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :latitude, :float, default: 0, null: false
    add_column :users, :longitude, :float, default: 0, null: false
  end
end
