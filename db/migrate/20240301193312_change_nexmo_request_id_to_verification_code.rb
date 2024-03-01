class ChangeNexmoRequestIdToVerificationCode < ActiveRecord::Migration[7.2]
  def change
    remove_column :phone_numbers, :nexmo_request_id
    add_column :phone_numbers,
               :verification_code,
               :string,
               default: "",
               null: false
  end
end
