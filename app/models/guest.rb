class Guest
  def self.singular_route_key
    :guest
  end

  def self.route_key
    :guests
  end

  def id
    nil
  end

  def time_zone
    nil
  end

  def admin?
    false
  end

  def to_model
    self
  end

  def model_name
    Guest
  end

  def persisted?
    false
  end

  def phone_numbers
    PhoneNumber.none
  end

  def slack_accounts
    SlackAccount.none
  end

  def x_accounts
    XAccount.none
  end

  def to_s
    "guest"
  end
end
