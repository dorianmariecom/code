class Current < ActiveSupport::CurrentAttributes
  attribute :user

  resets { Time.zone = nil }

  def user=(user)
    super
    Time.zone = user.time_zone
  end

  def primary_email_address
    return unless user
    user.primary_email_address || user.email_addresses.first
  end

  def primary_email_address!
    return primary_email_address if primary_email_address

    if user
      raise "You need to add an email address"
    else
      raise "You need to sign up or log in"
    end
  end
end
