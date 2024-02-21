class AddLocationToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :location, :string, default: "", null: false
  end
end
