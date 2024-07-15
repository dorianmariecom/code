class CreatePrompts < ActiveRecord::Migration[8.0]
  def change
    create_table :prompts do |t|
      t.references :user, foreign_key: true
      t.references :program, foreign_key: true
      t.text :prompt
      t.text :input

      t.timestamps
    end
  end
end
