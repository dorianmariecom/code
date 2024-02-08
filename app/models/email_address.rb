class EmailAddress < ApplicationRecord
  belongs_to :user, default: -> { Current.user }

  validates :email_address, presence: true
  validates :email_address, format: { with: URI::MailTo::EMAIL_REGEXP }

  def email_address_with_display_name
    ActionMailer::Base.email_address_with_name(email_address, display_name)
  end
end
