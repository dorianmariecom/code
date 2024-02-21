class RemoveSmtpFields < ActiveRecord::Migration[7.2]
  def change
    remove_column :email_addresses, :display_name
    remove_column :email_addresses, :smtp_address
    remove_column :email_addresses, :smtp_port
    remove_column :email_addresses, :smtp_user_name
    remove_column :email_addresses, :smtp_password
    remove_column :email_addresses, :smtp_authentication
    remove_column :email_addresses, :smtp_enable_starttls_auto
  end
end
