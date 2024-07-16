class EmailAddressMailer < ApplicationMailer
  def code_mail
    mail(
      from: params[:from],
      to: params[:to],
      subject: params[:subject],
      body: params[:body],
      reply_to: params[:reply_to]
    )
  end

  def verification_code_email
    @email_address = params[:email_address]
    @verification_code = @email_address.verification_code
    @host = ENV.fetch("HOST")

    mail(
      to: @email_address.email_address_with_name,
      subject: t(".subject", verification_code: @verification_code, host: @host)
    )
  end
end
