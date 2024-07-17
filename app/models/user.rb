# frozen_string_literal: true

class User < ApplicationRecord
  has_many :data, dependent: :destroy
  has_many :email_addresses, dependent: :destroy
  has_many :locations, dependent: :destroy
  has_many :locations, dependent: :destroy
  has_many :names, dependent: :destroy
  has_many :passwords, dependent: :destroy
  has_many :phone_numbers, dependent: :destroy
  has_many :programs, dependent: :destroy
  has_many :slack_accounts, dependent: :destroy
  has_many :smtp_accounts, dependent: :destroy
  has_many :time_zones, dependent: :destroy
  has_many :x_accounts, dependent: :destroy

  def name
    names.verified.primary.first&.name || names.verified.first&.name
  end

  def email_address
    email_addresses.verified.primary.first&.email_address ||
      email_addresses.verified.first&.email_address
  end

  def phone_number
    phone_numbers.verified.primary.first&.phone_number ||
      phone_numbers.verified.first&.phone_number
  end

  def to_s
    name.presence || email_address.presence || phone_number.presence ||
      "user##{id}"
  end
end
