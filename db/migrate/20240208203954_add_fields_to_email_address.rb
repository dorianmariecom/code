# frozen_string_literal: true

class AddFieldsToEmailAddress < ActiveRecord::Migration[7.1]
  def change
    add_column(
      :email_addresses,
      :smtp_address,
      :string,
      default: "smtp.gmail.com",
      null: false
    )
    add_column(:email_addresses, :smtp_port, :bigint, default: 465, null: false)
    add_column(:email_addresses, :smtp_user_name, :string, null: false)
    add_column(:email_addresses, :smtp_password, :string, null: false)
    add_column(
      :email_addresses,
      :smtp_authentication,
      :string,
      default: "plain",
      null: false
    )
    add_column(
      :email_addresses,
      :smtp_enable_starttls_auto,
      :boolean,
      default: true,
      null: false
    )
  end
end
