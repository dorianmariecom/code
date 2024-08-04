class CreatePages < ActiveRecord::Migration[8.0]
  def change
    create_table :pages do |t|
      t.references :page, foreign_key: true
      t.string :title
      t.text :body
      t.string :slug, null: false

      t.timestamps
    end
    add_index :pages, :slug, unique: true
  end
end
