# frozen_string_literal: true

class SmtpAccountsController < ApplicationController
  before_action :load_user
  before_action :load_smtp_account, only: %i[show edit update destroy]

  def index
    authorize SmtpAccount

    @smtp_accounts = scope
  end

  def show
  end

  def new
    @smtp_account =
      authorize scope.new(primary: current_user.smtp_accounts.none?)
  end

  def create
    @smtp_account = authorize scope.new(smtp_account_params)

    if @smtp_account.save
      redirect_to @smtp_account, notice: t(".notice")
    else
      flash.now.alert = @smtp_account.alert
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @smtp_account.update(smtp_account_params)
      redirect_to @smtp_account, notice: t(".notice")
    else
      flash.now.alert = @smtp_account.alert
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @smtp_account.destroy!

    redirect_to @smtp_account.user, notice: t(".notice")
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
      policy_scope(SmtpAccount).where(user: @user)
    else
      policy_scope(SmtpAccount)
    end
  end

  def id
    params[:smtp_account_id].presence || params[:id]
  end

  def load_smtp_account
    @smtp_account = authorize scope.find(id)
  end

  def smtp_account_params
    if admin?
      params.require(:smtp_account).permit(
        :user_id,
        :primary,
        :verified,
        :smtp_account
      )
    else
      params.require(:smtp_account).permit(:primary, :smtp_account)
    end
  end
end
