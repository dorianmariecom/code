class AddConversationsToSlackAccounts < ActiveRecord::Migration[7.2]
  def change
    add_column :slack_accounts, :conversations, :jsonb, default: {}, null: false
  end
end
