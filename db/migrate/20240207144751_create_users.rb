# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users, &:timestamps
  end
end
