class RemoveUrlFromSlackAccounts < ActiveRecord::Migration[7.2]
  def change
    remove_column :slack_accounts, :url
    remove_column :slack_accounts, :name
  end
end
