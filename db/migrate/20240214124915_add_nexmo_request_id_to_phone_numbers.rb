# frozen_string_literal: true

class AddNexmoRequestIdToPhoneNumbers < ActiveRecord::Migration[7.1]
  def change
    add_column :phone_numbers, :nexmo_request_id, :string, default: '', null: false
  end
end
