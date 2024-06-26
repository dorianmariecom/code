# frozen_string_literal: true

class XAccountsController < ApplicationController
  before_action :load_user
  before_action(
    :load_x_account,
    only: %i[show edit update destroy refresh_auth refresh_me]
  )

  def index
    authorize XAccount

    @x_accounts = scope
  end

  def refresh_auth
    @x_account.refresh_auth!
    redirect_back_or_to(@x_account)
  end

  def refresh_me
    @x_account.refresh_me!
    redirect_back_or_to(@x_account)
  end

  def callback
    Current.user =
      User.find_signed!(
        Base64.decode64(params[:state]),
        purpose: XAccount.purpose
      )
    session[:user_id] = Current.user.id
    authorize XAccount
    redirect_to policy_scope(XAccount).verify!(code: params[:code])
  end

  def show
  end

  def new
    @x_account = authorize policy_scope(XAccount).new
  end

  def edit
  end

  def update
    if @x_account.update(x_account_params)
      redirect_to @x_account, notice: t(".notice")
    else
      flash.now.alert = @x_account.alert
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @x_account.destroy!

    redirect_to @x_account.user, notice: t(".notice")
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
    @user ? policy_scope(XAccount).where(user: @user) : policy_scope(XAccount)
  end

  def id
    params[:x_account_id].presence || params[:id]
  end

  def load_x_account
    @x_account = authorize scope.find(id)
  end

  def x_account_params
    if admin?
      params.require(:x_account).permit(:user_id, :verified, :primary)
    else
      params.require(:x_account).permit(:primary)
    end
  end
end
