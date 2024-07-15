# frozen_string_literal: true

class Current < ActiveSupport::CurrentAttributes
  delegate(
    :admin?,
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
  resets { @user = nil }

  def user
    @user ||= User.create!
  end

  def user=(user)
    Time.zone = user&.time_zone.presence
    @user = user || User.create!
  end

  def user!
    user || raise(Code::Error, "no user")
  end

  def user?
    !!user
  end

  def email_addresses
    return [] unless user?
    user.email_addresses.verified
  end

  def email_addresses?
    email_addresses.any?
  end

  def email_addresses!
    user!
    raise(Code::Error, "no email addresses found") unless email_addresses?
    email_addresses
  end

  def primary_email_address
    return unless user?
    email_addresses.verified.primary.first || email_addresses.verified.first
  end

  def primary_email_address!
    primary_email_address ||
      raise(Code::Error, "no verified email address found")
  end

  def primary_email_address?
    !!primary_email_address
  end

  def phone_numbers
    return [] unless user?
    user.phone_numbers.verified
  end

  def phone_numbers?
    phone_numbers.any?
  end

  def phone_numbers!
    user!
    raise(Code::Error, "no phone numbers found") unless phone_numbers?
    phone_numbers
  end

  def primary_phone_number
    return unless user?
    phone_numbers.verified.primary.first || phone_numbers.verified.first
  end

  def primary_phone_number!
    primary_phone_number || raise(Code::Error, "no verified phone number found")
  end

  def primary_phone_number?
    !!primary_phone_number
  end

  def slack_accounts
    return [] unless user?
    user.slack_accounts.verified
  end

  def slack_accounts!
    user!
    raise(Code::Error, "no slack accounts found") unless slack_accounts?
    slack_accounts
  end

  def slack_accounts?
    slack_accounts.any?
  end

  def primary_slack_account
    return unless user?
    slack_accounts.verified.primary.first || slack_accounts.verified.first
  end

  def primary_slack_account!
    primary_slack_account ||
      raise(Code::Error, "no verified slack account found")
  end

  def primary_slack_account?
    !!primary_slack_account
  end

  def passwords
    return [] unless user?
    user.passwords
  end

  def passwords!
    user!
    raise(Code::Error, "no passwords found") unless passwords?
    passwords
  end

  def passwords?
    passwords.any?
  end

  def primary_password
    return unless user?
    passwords.first
  end

  def primary_password!
    primary_password || raise(Code::Error, "no password found")
  end

  def primary_password?
    !!primary_password
  end

  def programs
    return [] unless user?
    user.programs
  end

  def programs?
    programs.any?
  end

  def programs!
    user!
    raise(Code::Error, "no programs found") unless programs?
    programs
  end

  def primary_program
    return unless user?
    programs.first
  end

  def primary_program?
    !!primary_program
  end

  def primary_program!
    primary_program || raise(Code::Error, "no program found")
  end

  def schedules
    return [] unless user?
    return [] unless primary_program?
    primary_program.schedules
  end

  def schedules?
    schedules.any?
  end

  def schedules!
    user!
    primary_program!
    raise(Code::Error, "no schedules found") unless schedules?
    schedules
  end

  def primary_schedule
    schedules.first
  end

  def primary_schedule!
    primary_schedule || raise(Code::Error, "no schedule found")
  end

  def primary_schedule?
    !!primary_schedule
  end

  def smtp_accounts
    return [] unless user?
    user.smtp_accounts.verified
  end

  def smtp_accounts!
    user!
    raise(Code::Error, "no smtp accounts found") unless smtp_accounts?
    smtp_accounts
  end

  def smtp_accounts?
    smtp_accounts.any?
  end

  def primary_smtp_account
    return unless user?
    smtp_accounts.verified.primary.first || smtp_accounts.verified.first
  end

  def primary_smtp_account!
    primary_smtp_account || raise(Code::Error, "no verified smtp account found")
  end

  def primary_smtp_account?
    !!primary_smtp_account
  end

  def x_accounts
    return [] unless user?
    user.x_accounts.verified
  end

  def x_accounts?
    x_accounts.any?
  end

  def x_accounts!
    user!
    raise(Code::Error, "no x accounts found") unless x_accounts?
    x_accounts
  end

  def primary_x_account
    return unless user?
    x_accounts.verified.primary.first || x_accounts.verified.first
  end

  def primary_x_account!
    primary_x_account || raise(Code::Error, "no verified x account found")
  end

  def primary_x_account?
    !!primary_x_account
  end
end
