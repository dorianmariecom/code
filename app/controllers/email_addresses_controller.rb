# frozen_string_literal: true

class EmailAddressesController < ApplicationController
  before_action :load_user
  before_action :load_email_address, only: %i[show edit update destroy]

  helper_method :verification_code_param
  helper_method :id
  helper_method :url

  def index
    authorize EmailAddress

    @email_addresses = scope.page(params[:page])
  end

  def show
  end

  def new
    @email_address =
      authorize scope.new(primary: current_user.email_addresses.none?)
  end

  def create
    @email_address = authorize scope.new(email_address_params)

    if @email_address.save
      redirect_to @email_address, notice: t(".notice")
    else
      flash.now.alert = @email_address.alert
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @email_address.update(email_address_params)
      redirect_to @email_address, notice: t(".notice")
    else
      flash.now.alert = @email_address.alert
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @email_address.destroy!

    redirect_to url, notice: t(".notice")
  end

  def destroy_all
    authorize EmailAddress

    scope.destroy_all

    redirect_back_or_to(url)
  end

  private

  def load_user
    if params[:user_id] == "me"
      @user = current_user
    elsif params[:user_id].present?
      @user = policy_scope(User).find(params[:user_id])
    end
  end

  def scope
    if @user
      policy_scope(EmailAddress).where(user: @user)
    else
      policy_scope(EmailAddress)
    end
  end

  def id
    params[:email_address_id].presence || params[:id]
  end

  def url
    @user ? [@user, :email_addresses] : email_addresses_path
  end

  def load_email_address
    @email_address =
      EmailAddress
        .find_verification_code_signed!(id)
        .tap do
          skip_policy_scope
          skip_authorization
        end

    Current.user = @email_address.user
    session[:user_id] = Current.user.id

    @email_address
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    @email_address = authorize scope.find(id)
  end

  def verification_code_param
    params.dig(:email_address, :verification_code)
  end

  def email_address_params
    if admin?
      params.require(:email_address).permit(
        :user_id,
        :verified,
        :primary,
        :email_address
      )
    else
      params.require(:email_address).permit(:user_id, :primary, :email_address)
    end
  end
end
