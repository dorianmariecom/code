class Current < ActiveSupport::CurrentAttributes
  attribute :user

  resets { Time.zone = nil }

  def user=(user)
    super
    Time.zone = user&.time_zone
  end

  def email_addresses
    return unless user
    user.email_addresses
  end

  def email_addresses!
    email_addresses || raise(Code::Error.new("No email addresses found"))
  end

  def primary_email_address
    return unless user
    email_addresses.primary.first || email_addresses.first
  end

  def primary_email_address!
    primary_email_address || raise(Code::Error.new("No primary email address found"))
  end
end
