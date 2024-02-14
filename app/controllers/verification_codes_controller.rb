class VerificationCodesController < ApplicationController
  before_action :load_model, only: [:create, :update, :destroy]

  def create
    @model.send_verification_code!
    redirect_back_or_to @model
  end

  def update
  end

  def destroy
  end

  private

  def load_model
    if params[:phone_number_id].present?
      @model = authorize policy_scope(PhoneNumber).find(params[:phone_number_id])
    elsif params[:email_address_id].present?
      @model = authorize policy_scope(EmailAddress).find(params[:email_address_id])
    else
      raise NotImplementedError
    end
  end
end
