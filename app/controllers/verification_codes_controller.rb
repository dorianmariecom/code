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

  def load_verifiable
    if params[:phone_number_id].present?
      @verifiable =
        authorize policy_scope(PhoneNumber).find(params[:phone_number_id])
    elsif params[:email_address_id].present?
      @verifiable =
        authorize policy_scope(EmailAddress).find(params[:email_address_id])
    else
      raise NotImplementedError
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
