class CreateSmtpAccounts < ActiveRecord::Migration[7.2]
  def change
    create_table :smtp_accounts do |t|
      t.references :user, null: false, foreign_key: true
      t.boolean :primary, default: false, null: false
      t.boolean :verified, default: false, null: false
      t.string :address, default: "smtp.gmail.com", null: false
      t.bigint :port, default: 587, null: false
      t.string :user_name, default: "", null: false
      t.string :password, default: "", null: false
      t.string :authentication, default: "plain", null: false
      t.boolean :enable_starttls_auto, default: true, null: false

      t.timestamps
    end
  end
end
