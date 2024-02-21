class AddDisplayNameToSmtpAccounts < ActiveRecord::Migration[7.2]
  def change
    add_column :smtp_accounts, :display_name, :string, default: "", null: false
  end
end
