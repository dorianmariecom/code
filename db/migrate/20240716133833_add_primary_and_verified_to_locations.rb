class AddPrimaryAndVerifiedToLocations < ActiveRecord::Migration[8.0]
  def change
    add_column :locations, :primary, :boolean, default: false, null: false
    add_column :locations, :verified, :boolean, default: false, null: false
  end
end
