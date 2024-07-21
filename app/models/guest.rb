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

  def data
    Datum.none
  end

  def passwords
    Password.none
  end

  def programs
    Program.none
  end

  def locations
    Location.none
  end

  def time_zones
    TimeZone.none
  end

  def names
    Name.none
  end

  def to_signed_global_id(purpose: nil, expires_in: nil)
    ""
  end

  def signed_id(purpose: nil, expires_in: nil)
    ""
  end

  def to_s
    "guest"
  end
end
