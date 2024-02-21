class AddPrimaryToSlackAccount < ActiveRecord::Migration[7.2]
  def change
    add_column :slack_accounts, :primary, :boolean, default: false, null: false
    add_column :slack_accounts, :verified, :boolean, default: false, null: false
  end
end
