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

  def data = Datum.none
  def devices = Device.none
  def email_addresses = EmailAddress.none
  def locations = Location.none
  def names = Name.none
  def passwords = Password.none
  def phone_numbers = PhoneNumber.none
  def programs = Program.none
  def prompts = Prompt.none
  def slack_accounts = SlackAccount.none
  def smtp_accounts = SmtpAccount.none
  def time_zones = TimeZone.none
  def x_accounts = XAcount.none

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
