# frozen_string_literal: true

class AddPromptToProgram < ActiveRecord::Migration[7.1]
  def change
    add_column :programs, :prompt, :text, default: "", null: false
  end
end
