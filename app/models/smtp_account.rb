class SmtpAccount < ApplicationRecord
  EMAIL_ADDRESS_REGEXP = URI::MailTo::EMAIL_REGEXP
  DOMAIN_REGEXP = /\A[a-zA-Z0-9]+([-.]{1}[a-zA-Z0-9]+)*\.[a-zA-Z]{2,5}\z/

  encrypts :password

  belongs_to :user, default: -> { Current.user }

  scope :primary, -> { where(primary: true) }
  scope :not_primary, -> { where(primary: false) }
  scope :verified, -> { where(verified: true) }
  scope :not_verified, -> { where(verified: false) }

  normalizes(:user_name, with: ->(user_name) { user_name.to_s.downcase.strip })

  validates :address, presence: true, format: { with: DOMAIN_REGEXP }
  validates :port, presence: true
  validates :user_name, presence: true, format: { with: EMAIL_ADDRESS_REGEXP }
  validates :password, presence: true
  validates :authentication, presence: true

  def email_address_with_name
    ActionMailer::Base.email_address_with_name(user_name, display_name)
  end

  def primary?
    !!primary
  end

  def not_primary?
    !primary?
  end

  def verified?
    !!verified
  end

  def not_verified?
    !verified?
  end

  def deliver!(from:, to:, subject:, body:)
    mail = Mail.new
    mail.from = from
    mail.to = to
    mail.subject = subject
    mail.body = body
    mail.delivery_method(
      :smtp,
      address: smtp_address,
      port: smtp_port,
      user_name: smtp_user_name,
      password: smtp_password,
      authentication: smtp_authentication,
      enable_starttls_auto: smtp_enable_starttls_auto
    )
    mail.deliver!
  end

  def to_s
    user_name.presence || "SmtpAccount##{id}"
  end
end
