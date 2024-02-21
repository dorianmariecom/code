# frozen_string_literal: true

class CreatePrograms < ActiveRecord::Migration[7.1]
  def change
    create_table :programs do |t|
      t.references :user, foreign_key: true

      t.text :input
      t.text :output
      t.text :error
      t.text :result

      t.timestamps
    end
  end
end
