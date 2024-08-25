# frozen_string_literal: true

class EmailAddressMailerPreview < ActionMailer::Preview
  def verification_code_email
    EmailAddressMailer.with(
      email_address: EmailAddress.last!
    ).verification_code_email
  end
end
