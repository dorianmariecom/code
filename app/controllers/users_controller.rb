# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :load_user, only: %i[show edit update destroy]

  def index
    authorize User
    @users = scope.order(:id).page(params[:page])
  end

  def show
    @data = policy_scope(Datum).where(user: @user).page(params[:page])
    @email_addresses =
      policy_scope(EmailAddress).where(user: @user).page(params[:page])
    @locations = policy_scope(Location).where(user: @user).page(params[:page])
    @names = policy_scope(Name).where(user: @user).page(params[:page])
    @passwords = policy_scope(Password).where(user: @user).page(params[:page])
    @phone_numbers =
      policy_scope(PhoneNumber).where(user: @user).page(params[:page])
    @programs = policy_scope(Program).where(user: @user).page(params[:page])
    @prompts = policy_scope(Prompt).where(user: @user).page(params[:page])
    @slack_accounts =
      policy_scope(SlackAccount).where(user: @user).page(params[:page])
    @smtp_accounts =
      policy_scope(SmtpAccount).where(user: @user).page(params[:page])
    @time_zones = policy_scope(TimeZone).where(user: @user).page(params[:page])
    @x_accounts = policy_scope(XAccount).where(user: @user).page(params[:page])
  end

  def new
    @user = authorize scope.new
  end

  def create
    @user = authorize scope.new

    if @user.save
      log_in(@user)
      redirect_to @user, notice: t(".notice")
    else
      flash.now.alert = @user.alert
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @user.touch
      log_in(@user)
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
