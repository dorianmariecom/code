class AddLocationFieldsToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :city, :string, default: "", null: false
    add_column :users, :street_number, :string, default: "", null: false
    add_column :users, :route, :string, default: "", null: false
    add_column :users, :county, :string, default: "", null: false
    add_column :users, :state, :string, default: "", null: false
    add_column :users, :postal_code, :string, default: "", null: false
    add_column :users, :country, :string, default: "", null: false
  end
end
