class EmailAddress < ApplicationRecord
  EMAIL_ADDRESS_REGEXP = URI::MailTo::EMAIL_REGEXP
  DOMAIN_REGEXP = /\A[a-zA-Z0-9]+([\-\.]{1}[a-zA-Z0-9]+)*\.[a-zA-Z]{2,5}\z/

  belongs_to :user, default: -> { Current.user }

  encrypts :smtp_password

  validates :email_address, presence: true
  validates :email_address, format: { with: EMAIL_ADDRESS_REGEXP }
  validates :smtp_address, presence: true, format: { with: DOMAIN_REGEXP }
  validates :smtp_port, presence: true
  validates :smtp_user_name, presence: true, format: { with: EMAIL_ADDRESS_REGEXP }
  validates :smtp_authentication, presence: true

  scope :primary, -> { where(primary: true) }

  def email_address_with_display_name
    ActionMailer::Base.email_address_with_name(email_address, display_name)
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
end
