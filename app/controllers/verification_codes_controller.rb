# frozen_string_literal: true

class VerificationCodesController < ApplicationController
  before_action :load_verifiable, only: %i[create update destroy]

  def create
    @verifiable.send_verification_code!
    redirect_back_or_to @verifiable
  end

  def update
    @verifiable.verify!(verification_code_param)
    redirect_back_or_to @verifiable
  end

  def destroy
    @verifiable.cancel_verification!
    redirect_back_or_to @verifiable
  end

  private

  def id
    params[:phone_number_id] || params[:email_address_id] || params[:smtp_account_id]
  end

  def load_verifiable
    if params[:phone_number_id].present?
      @verifiable = authorize policy_scope(PhoneNumber).find(id)
    elsif params[:email_address_id].present?
      begin
        @verifiable =
          EmailAddress
            .find_verification_code_signed!(id)
            .tap do
              skip_policy_scope
              skip_authorization
            end
      rescue ActiveSupport::MessageVerifier::InvalidSignature
        @verifiable = authorize policy_scope(EmailAddress).find(id)
      end
    elsif params[:smtp_account_id].present?
      @verifiable = authorize policy_scope(SmtpAccount).find(id)
    else
      raise NotImplementedError, params.inspect
    end
  end

  def verification_code_param
    if params[:phone_number_id].present?
      params.dig(:phone_number, :verification_code)
    elsif params[:email_address_id].present?
      params.dig(:email_address, :verification_code)
    else
      raise NotImplementedError
    end
  end
end
