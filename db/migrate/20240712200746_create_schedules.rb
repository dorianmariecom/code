class CreateSchedules < ActiveRecord::Migration[8.0]
  def change
    create_table :schedules do |t|
      t.references :program, null: false, foreign_key: true
      t.time :at
      t.bigint :count
      t.string :per

      t.timestamps
    end
  end
end
