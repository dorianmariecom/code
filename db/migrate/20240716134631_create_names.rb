class CreateNames < ActiveRecord::Migration[8.0]
  def change
    create_table :names do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.boolean :primary, default: false, null: false
      t.boolean :verified, default: false, null: false

      t.timestamps
    end
  end
end
