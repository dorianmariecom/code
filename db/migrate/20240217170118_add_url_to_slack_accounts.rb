class AddUrlToSlackAccounts < ActiveRecord::Migration[7.2]
  def change
    add_column :slack_accounts, :url, :string, default: "", null: false
  end
end
