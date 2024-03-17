# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :load_user, only: %i[show edit update destroy]

  def index
    authorize User
    @users = policy_scope(User).order(:id)
  end

  def show
    @email_addresses = policy_scope(EmailAddress).where(user: @user)
    @phone_numbers = policy_scope(PhoneNumber).where(user: @user)
    @slack_accounts = policy_scope(SlackAccount).where(user: @user)
    @twitter_accounts = policy_scope(TwitterAccount).where(user: @user)
    @smtp_accounts = policy_scope(SmtpAccount).where(user: @user)
    @passwords = policy_scope(Password).where(user: @user)
    @programs = policy_scope(Program).where(user: @user)
  end

  def new
    @user = authorize policy_scope(User).new
  end

  def create
    @user = authorize policy_scope(User).new(user_params)

    if @user.save
      session[:user_id] = @user.id unless admin?
      redirect_to @user, notice: t(".notice")
    else
      flash.now.alert = @user.alert
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: t(".notice")
    else
      flash.now.alert = @user.alert
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy!
    reset_session

    redirect_to root_path, notice: t(".notice")
  end

  private

  def load_user
    @user =
      if params[:id] == "me"
        authorize current_user
      else
        authorize policy_scope(User).find(params[:id])
      end
  end

  def user_params
    if admin?
      params.require(:user).permit(
        :name,
        :time_zone,
        :location,
        :city,
        :street_number,
        :route,
        :county,
        :state,
        :postal_code,
        :country,
        :latitude,
        :longitude,
        email_addresses_attributes: %i[
          user_id
          verified
          id
          _destroy
          primary
          email_address
        ],
        phone_numbers_attributes: %i[
          user_id
          verified
          id
          _destroy
          primary
          phone_number
        ],
        passwords_attributes: %i[user_id id _destroy password hint],
        smtp_accounts_attributes: %i[
          user_id
          verified
          id
          _destroy
          primary
          display_name
          address
          port
          user_name
          password
          authentication
          enable_starttls_auto
        ],
        slack_accounts_attributes: %i[user_id verified id _destroy primary]
      )
    else
      params.require(:user).permit(
        :name,
        :time_zone,
        :location,
        :city,
        :street_number,
        :route,
        :county,
        :state,
        :postal_code,
        :country,
        :latitude,
        :longitude,
        email_addresses_attributes: %i[id _destroy primary email_address],
        phone_numbers_attributes: %i[id _destroy primary phone_number],
        passwords_attributes: %i[id _destroy password hint],
        smtp_accounts_attributes: %i[
          id
          _destroy
          display_name
          primary
          address
          port
          user_name
          password
          authentication
          enable_starttls_auto
        ],
        slack_accounts_attributes: %i[id _destroy primary]
      )
    end
  end
end
