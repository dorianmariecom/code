class SmtpAccount < ApplicationRecord
  include ActionView::Helpers::SanitizeHelper

  EMAIL_ADDRESS_REGEXP = URI::MailTo::EMAIL_REGEXP
  DOMAIN_REGEXP = /\A[a-zA-Z0-9]+([-.]{1}[a-zA-Z0-9]+)*\.[a-zA-Z]{2,5}\z/

  encrypts :password

  belongs_to :user, default: -> { Current.user }, touch: true

  scope :primary, -> { where(primary: true) }
  scope :not_primary, -> { where(primary: false) }
  scope :verified, -> { where(verified: true) }
  scope :not_verified, -> { where(verified: false) }

  normalizes(:address, with: ->(address) { address.to_s.strip })
  normalizes(:user_name, with: ->(user_name) { user_name.to_s.strip })
  normalizes(
    :authentication,
    with: ->(authentication) { authentication.to_s.strip }
  )

  validates :address, presence: true, format: { with: DOMAIN_REGEXP }
  validates :port, presence: true
  validates :user_name, presence: true
  validates :password, presence: true
  validates :authentication, presence: true
  validate { can!(:update, user) }

  before_validation { self.user ||= User.create! }

  before_update do
    next if not_verified?

    if address_changed? || port_changed? || user_name_changed? ||
         password_changed? || authentication_changed? ||
         enable_starttls_auto_changed?
      unverify!
    end
  end

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

  def unverify!
    update!(verified: false)
  end

  def verifying?
    false
  end

  def send_verification_code!
    Net::SMTP.start(address, port) do |smtp|
      smtp.authenticate(user_name, password)
      update!(verified: true)
    end
  end

  def deliver!(
    from: "",
    to: "",
    subject: "",
    body: "",
    reply_to: "",
    text: "",
    html: ""
  )
    text = text.presence || body.presence || html.presence || ""
    text = strip_tags(text)

    html = html.presence.to_s.html_safe

    mail = Mail.new
    mail.from = from
    mail.to = to
    mail.subject = subject
    mail.text_part = Mail::Part.new(body: text)
    mail.html_part =
      Mail::Part.new(content_type: "text/html; charset=UTF-8", body: html)
    mail.reply_to = reply_to if reply_to.present?
    mail.delivery_method(
      :smtp,
      address:,
      port:,
      user_name:,
      password:,
      authentication:,
      enable_starttls_auto:
    )
    mail.deliver!
  end

  def to_s
    user_name.presence || "smtp_account##{id}"
  end
end
