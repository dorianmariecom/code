class CreateSlackAccounts < ActiveRecord::Migration[7.2]
  def change
    create_table :slack_accounts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false, default: ""
      t.string :token, null: false, default: ""

      t.timestamps
    end
  end
end
