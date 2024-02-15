# frozen_string_literal: true

class Current < ActiveSupport::CurrentAttributes
  attribute :user

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
end
