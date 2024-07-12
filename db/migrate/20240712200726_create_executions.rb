class CreateExecutions < ActiveRecord::Migration[8.0]
  def change
    create_table :executions do |t|
      t.references :program, null: false, foreign_key: true
      t.text :input
      t.text :output
      t.text :error
      t.text :result

      t.timestamps
    end
  end
end
