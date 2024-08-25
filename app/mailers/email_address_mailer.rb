# frozen_string_literal: true

class EmailAddressMailer < ApplicationMailer
  include ActionView::Helpers::SanitizeHelper

  def code_mail
    text =
      params[:body].presence || params[:text].presence ||
        params[:html].presence.to_s
    text = strip_tags(text)
    html = params[:html].presence.to_s

    mail(
      from: params[:from],
      to: params[:to],
      subject: params[:subject],
      reply_to: params[:reply_to]
    ) do |format|
      format.text { render(plain: text) }
      format.html { render(html:) } if html.present?
    end
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
