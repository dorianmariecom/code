class RenameTwitterAccountsToXAccounts < ActiveRecord::Migration[7.2]
  def change
    rename_table :x_accounts, :x_accounts
  end
end
