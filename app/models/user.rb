# frozen_string_literal: true

class User < ApplicationRecord
  has_many :data, dependent: :destroy
  has_many :email_addresses, dependent: :destroy
  has_many :locations, dependent: :destroy
  has_many :passwords, dependent: :destroy
  has_many :phone_numbers, dependent: :destroy
  has_many :programs, dependent: :destroy
  has_many :slack_accounts, dependent: :destroy
  has_many :smtp_accounts, dependent: :destroy
  has_many :x_accounts, dependent: :destroy

  def admin!
    update!(admin: true)
  end

  def to_s
    "user##{id}"
  end
end
