class AddMeToTwitterAccounts < ActiveRecord::Migration[7.2]
  def change
    add_column :twitter_accounts, :me, :jsonb, default: {}, null: false
  end
end
