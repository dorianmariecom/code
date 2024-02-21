# frozen_string_literal: true

class ChangeDefaultSmtpPortForEmailAddresses < ActiveRecord::Migration[7.1]
  def change
    change_column_default :email_addresses, :smtp_port, 587
  end
end
