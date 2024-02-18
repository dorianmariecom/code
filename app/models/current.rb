# frozen_string_literal: true

class Current < ActiveSupport::CurrentAttributes
  attribute :user

  delegate(
    :location,
    :latitude,
    :longitude,
    :city,
    :street_number,
    :route,
    :county,
    :state,
    :postal_code,
    :country,
    to: :user,
    allow_nil: true
  )

  resets { Time.zone = nil }

  def user=(user)
    super
    Time.zone = user&.time_zone
  end

  def email_addresses
    return unless user

    user.email_addresses.verified
  end

  def email_addresses!
    email_addresses || raise(Code::Error, "No email addresses found")
  end

  def primary_email_address
    return unless user

    email_addresses.verified.primary.first || email_addresses.verified.first
  end

  def primary_email_address!
    primary_email_address ||
      raise(Code::Error, "No primary email address found")
  end

  def phone_numbers
    return unless user

    user.phone_numbers.verified
  end

  def phone_numbers!
    phone_numbers || raise(Code::Error, "No phone numbers found")
  end

  def primary_phone_number
    return unless user

    phone_numbers.verified.primary.first || phone_numbers.verified.first
  end

  def primary_phone_number!
    primary_phone_number || raise(Code::Error, "No primary phone number found")
  end

  def slack_accounts
    return unless user

    user.slack_accounts.verified
  end

  def slack_accounts!
    slack_accounts || raise(Code::Error, "No slack accounts found")
  end

  def primary_slack_account
    return unless user

    slack_accounts.verified.primary.first || slack_accounts.verified.first
  end

  def primary_slack_account!
    primary_slack_account ||
      raise(Code::Error, "No primary slack account found")
  end
end
