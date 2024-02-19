class EmailAddressMailer < ApplicationMailer
  def verification_code_email
    @email_address = params[:email_address]
    @email_address.reset_verification_code!
    @verification_code = @email_address.verification_code
    @host = ENV.fetch("HOST")

    mail(
      to: @email_address.email_address_with_name,
      subject: t(".subject", verification_code: @verification_code, host: @host)
    )
  end
end
