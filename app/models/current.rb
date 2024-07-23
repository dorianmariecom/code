# frozen_string_literal: true

class Current < ActiveSupport::CurrentAttributes
  resets { Time.zone = nil }
  resets { @user = nil }

  attribute :user

  def user_or_guest
    user || guest
  end

  def admin?
    (user || guest).admin?
  end

  def user=(user)
    super(user)
    Time.zone = time_zone&.time_zone
  end

  def user!
    user || raise(Code::Error, "no user found")
  end

  def user?
    !!user
  end

  def guest?
    user.blank?
  end

  def guest
    Guest.new
  end

  def registered?
    user.present?
  end

  def email_addresses
    (user || guest).email_addresses.verified
  end

  def email_addresses?
    email_addresses.any?
  end

  def email_addresses!
    raise(Code::Error, "no verified email addresses found") unless email_addresses?
    email_addresses
  end

  def email_address
    email_addresses.verified.primary.first || email_addresses.verified.first
  end

  def email_address!
    email_address || raise(Code::Error, "no verified email address found")
  end

  def email_address?
    !!email_address
  end

  def phone_numbers
    (user || guest).phone_numbers.verified
  end

  def phone_numbers?
    phone_numbers.any?
  end

  def phone_numbers!
    raise(Code::Error, "no verified phone numbers found") unless phone_numbers?
    phone_numbers
  end

  def phone_number
    phone_numbers.verified.primary.first || phone_numbers.verified.first
  end

  def phone_number!
    phone_number || raise(Code::Error, "no verified phone number found")
  end

  def phone_number?
    !!phone_number
  end

  def slack_accounts
    (user || guest).slack_accounts.verified
  end

  def slack_accounts!
    raise(Code::Error, "no verified slack accounts found") unless slack_accounts?
    slack_accounts
  end

  def slack_accounts?
    slack_accounts.any?
  end

  def slack_account
    slack_accounts.verified.primary.first || slack_accounts.verified.first
  end

  def slack_account!
    slack_account || raise(Code::Error, "no verified slack account found")
  end

  def slack_account?
    !!slack_account
  end

  def passwords
    (user || guest).passwords
  end

  def passwords!
    raise(Code::Error, "no passwords found") unless passwords?
    passwords
  end

  def passwords?
    passwords.any?
  end

  def password
    passwords.first
  end

  def password!
    password || raise(Code::Error, "no password found")
  end

  def password?
    !!password
  end

  def programs
    (user || guest).programs
  end

  def programs?
    programs.any?
  end

  def programs!
    raise(Code::Error, "no programs found") unless programs?
    programs
  end

  def program
    programs.first
  end

  def program?
    !!program
  end

  def program!
    program || raise(Code::Error, "no program found")
  end

  def schedules
    program&.schedules || Schedule.none
  end

  def schedules?
    schedules.any?
  end

  def schedules!
    raise(Code::Error, "no schedules found") unless schedules?
    schedules
  end

  def schedule
    schedules.first
  end

  def schedule!
    schedule || raise(Code::Error, "no schedule found")
  end

  def schedule?
    !!schedule
  end

  def smtp_accounts
    (user || guest).smtp_accounts.verified
  end

  def smtp_accounts!
    raise(Code::Error, "no verified smtp accounts found") unless smtp_accounts?
    smtp_accounts
  end

  def smtp_accounts?
    smtp_accounts.any?
  end

  def smtp_account
    smtp_accounts.verified.primary.first || smtp_accounts.verified.first
  end

  def smtp_account!
    smtp_account || raise(Code::Error, "no verified smtp account found")
  end

  def smtp_account?
    !!smtp_account
  end

  def x_accounts
    (user || guest).x_accounts.verified
  end

  def x_accounts?
    x_accounts.any?
  end

  def x_accounts!
    raise(Code::Error, "no verified x accounts found") unless x_accounts?
    x_accounts
  end

  def x_account
    x_accounts.verified.primary.first || x_accounts.verified.first
  end

  def x_account!
    x_account || raise(Code::Error, "no verified x account found")
  end

  def x_account?
    !!x_account
  end

  def names
    (user || guest).names.verified
  end

  def names?
    names.any?
  end

  def names!
    raise(Code::Error, "no verified name found") unless names?
    names
  end

  def name
    names.verified.primary.first || names.verified.first
  end

  def name!
    name || raise(Code::Error, "no verified name found")
  end

  def name?
    !!name
  end

  def time_zones
    (user || guest).time_zones.verified
  end

  def time_zones?
    time_zones.any?
  end

  def time_zones!
    raise(Code::Error, "no verified time zone found") unless time_zones?
    time_zones
  end

  def time_zone
    time_zones.verified.primary.first || time_zones.verified.first
  end

  def time_zone!
    time_zone || raise(Code::Error, "no verified time zone found")
  end

  def time_zone?
    !!time_zone
  end

  def locations
    (user || guest).locations.verified
  end

  def locations?
    locations.any?
  end

  def locations!
    raise(Code::Error, "no verified location found") unless locations?
    locations
  end

  def location
    locations.verified.primary.first || locations.verified.first
  end

  def location!
    location || raise(Code::Error, "no verified location found")
  end

  def location?
    !!location
  end
end
