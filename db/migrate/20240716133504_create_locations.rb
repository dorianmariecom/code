class CreateLocations < ActiveRecord::Migration[8.0]
  def change
    create_table :locations do |t|
      t.references :user, null: false, foreign_key: true
      t.string :location
      t.string :city
      t.string :street_number
      t.string :route
      t.string :county
      t.string :state
      t.string :postal_code
      t.string :country
      t.string :latitude
      t.string :longitude

      t.timestamps
    end
  end
end
