class AddSlackFieldsToSlackAccounts < ActiveRecord::Migration[7.2]
  def change
    remove_column :slack_accounts, :token
    add_column :slack_accounts, :auth, :jsonb, default: {}, null: false
  end
end
