# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :load_user, only: %i[show edit update destroy]

  def index
    authorize User
    @users = scope.order(:id)
  end

  def show
    @data = policy_scope(Datum).where(user: @user)
    @email_addresses = policy_scope(EmailAddress).where(user: @user)
    @locations = policy_scope(Location).where(user: @user)
    @names = policy_scope(Name).where(user: @user)
    @passwords = policy_scope(Password).where(user: @user)
    @phone_numbers = policy_scope(PhoneNumber).where(user: @user)
    @programs = policy_scope(Program).where(user: @user)
    @prompts = policy_scope(Prompt).where(user: @user)
    @slack_accounts = policy_scope(SlackAccount).where(user: @user)
    @smtp_accounts = policy_scope(SmtpAccount).where(user: @user)
    @time_zones = policy_scope(TimeZone).where(user: @user)
    @x_accounts = policy_scope(XAccount).where(user: @user)
  end

  def new
    @user = authorize scope.new
  end

  def create
    @user = authorize scope.new

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
    if @user.update({})
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
end
