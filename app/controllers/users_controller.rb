# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :load_user, only: %i[show edit update destroy]

  def index
    authorize User
    @users = scope.order(:id)
  end

  def show
    @email_addresses = policy_scope(EmailAddress).where(user: @user)
    @phone_numbers = policy_scope(PhoneNumber).where(user: @user)
    @slack_accounts = policy_scope(SlackAccount).where(user: @user)
    @x_accounts = policy_scope(XAccount).where(user: @user)
    @smtp_accounts = policy_scope(SmtpAccount).where(user: @user)
    @passwords = policy_scope(Password).where(user: @user)
    @programs = policy_scope(Program).where(user: @user)
  end

  def new
    @user = authorize scope.new
  end

  def create
    @user = authorize scope.new(user_params)

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

  def destroy_all
    authorize User

    scope.destroy_all

    reset_session

    redirect_back_or_to(root_path)
  end

  private

  def load_user
    @user =
      if params[:id] == "me"
        authorize current_user
      else
        authorize scope.find(params[:id])
      end
  end

  def scope
    policy_scope(User)
  end

  def user_params
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
      :longitude
    )
  end
end
