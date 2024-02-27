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
    Time.zone = user&.time_zone.presence
  end

  def user!
    user || raise(Code::Error, "No user")
  end

  def user?
    !!user
  end

  def email_addresses
    return unless user?
    user.email_addresses.verified
  end

  def email_addresses!
    user!
    raise(Code::Error, "No email addresses found") if email_addresses.none?
    email_addresses
  end

  def primary_email_address
    return unless user?
    email_addresses.verified.primary.first || email_addresses.verified.first
  end

  def primary_email_address!
    primary_email_address ||
      raise(Code::Error, "No verified email address found")
  end

  def phone_numbers
    return unless user?
    user.phone_numbers.verified
  end

  def phone_numbers!
    user!
    raise(Code::Error, "No phone numbers found") if phone_numbers.none?
    phone_numbers
  end

  def primary_phone_number
    return unless user?
    phone_numbers.verified.primary.first || phone_numbers.verified.first
  end

  def primary_phone_number!
    primary_phone_number || raise(Code::Error, "No verified phone number found")
  end

  def slack_accounts
    return unless user?
    user.slack_accounts.verified
  end

  def slack_accounts!
    user!
    raise(Code::Error, "No slack accounts found") if slack_accounts.none?
    slack_accounts
  end

  def primary_slack_account
    return unless user?
    slack_accounts.verified.primary.first || slack_accounts.verified.first
  end

  def primary_slack_account!
    primary_slack_account ||
      raise(Code::Error, "No verified slack account found")
  end

  def passwords
    return unless user?
    user.passwords
  end

  def passwords!
    user!
    raise(Code::Error, "No passwords found") if passwords.none?
    passwords
  end

  def primary_password
    return unless user?
    passwords.first
  end

  def primary_password!
    primary_password || raise(Code::Error, "No password found")
  end

  def programs
    return unless user?
    user.programs
  end

  def programs!
    user!
    raise(Code::Error, "No programs found") if programs.none?
    programs
  end

  def primary_program
    return unless user?
    programs.first
  end

  def primary_program!
    primary_program || raise(Code::Error, "No program found")
  end

  def smtp_accounts
    return unless user?
    user.smtp_accounts.verified
  end

  def smtp_accounts!
    user!
    raise(Code::Error, "No smtp accounts found") if smtp_accounts.none?
    smtp_accounts
  end

  def primary_smtp_account
    return unless user?
    smtp_accounts.verified.primary.first || smtp_accounts.verified.first
  end

  def primary_smtp_account!
    primary_smtp_account || raise(Code::Error, "No verified smtp account found")
  end
end
