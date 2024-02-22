class AddVerificationCodeToEmailAddresses < ActiveRecord::Migration[7.2]
  def change
    add_column :email_addresses,
               :verification_code,
               :string,
               default: "",
               null: false
  end
end
