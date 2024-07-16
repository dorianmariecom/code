class RemoveLocationFromUsers < ActiveRecord::Migration[8.0]
  def change
    remove_column :users, :location
    remove_column :users, :city
    remove_column :users, :street_number
    remove_column :users, :route
    remove_column :users, :county
    remove_column :users, :state
    remove_column :users, :postal_code
    remove_column :users, :country
    remove_column :users, :latitude
    remove_column :users, :longitude
  end
end
