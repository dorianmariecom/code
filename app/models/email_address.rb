class EmailAddress < ApplicationRecord
  belongs_to :user, default: -> { Current.user }

  encrypts :smtp_password

  validates :email_address, presence: true
  validates :email_address, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :smtp_address, presence: true
  validates :smtp_port, presence: true
  validates :smtp_user_name, presence: true
  validates :smtp_password, presence: true
  validates :smtp_authentication, presence: true

  after_commit do
    if user && user.primary_email_address.nil?
      user.update!(primary_email_address: self)
    end
  end

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
