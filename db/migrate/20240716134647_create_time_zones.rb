class CreateTimeZones < ActiveRecord::Migration[8.0]
  def change
    create_table :time_zones do |t|
      t.references :user, null: false, foreign_key: true
      t.string :time_zone
      t.boolean :primary, default: false, null: false
      t.boolean :verified, default: false, null: false

      t.timestamps
    end
  end
end
