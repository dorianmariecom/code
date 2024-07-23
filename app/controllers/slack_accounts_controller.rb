# frozen_string_literal: true

class SlackAccountsController < ApplicationController
  before_action :load_user
  before_action :load_slack_account, only: %i[show edit update destroy]

  helper_method :url

  def index
    authorize SlackAccount

    @slack_accounts = scope.page(params[:page])
  end

  def callback
    authorize SlackAccount

    @slack_account = policy_scope(SlackAccount).verify!(code: params[:code])

    log_in(@slack_account.user)

    redirect_to @slack_account
  end

  def show
  end

  def new
    @slack_account = authorize policy_scope(SlackAccount).new
  end

  def edit
  end

  def update
    if @slack_account.update(slack_account_params)
      log_in(@slack_account.user)
      redirect_to @slack_account, notice: t(".notice")
    else
      flash.now.alert = @slack_account.alert
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @slack_account.destroy!

    redirect_to url, notice: t(".notice")
  end

  def destroy_all
    authorize SlackAccount

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
      policy_scope(SlackAccount).where(user: @user)
    else
      policy_scope(SlackAccount)
    end
  end

  def url
    @user ? [@user, :slack_accounts] : slack_accounts_path
  end

  def id
    params[:slack_account_id].presence || params[:id]
  end

  def load_slack_account
    @slack_account = authorize scope.find(id)
  end

  def slack_account_params
    if admin?
      params.require(:slack_account).permit(:user_id, :verified, :primary)
    else
      params.require(:slack_account).permit(:user_id, :primary)
    end
  end
end
