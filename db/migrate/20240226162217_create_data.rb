class CreateData < ActiveRecord::Migration[7.2]
  def change
    create_table :data do |t|
      t.references :user, null: false, foreign_key: true
      t.jsonb :data

      t.timestamps
    end
  end
end
