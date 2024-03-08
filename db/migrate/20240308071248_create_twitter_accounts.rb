class CreateTwitterAccounts < ActiveRecord::Migration[7.1]
  def change
    create_table :twitter_accounts do |t|
      t.references :user, null: false, foreign_key: true
      t.boolean :verified, default: false, null: false
      t.boolean :primary, default: false, null: false
      t.jsonb :auth, default: {}, null: false

      t.timestamps
    end
  end
end
