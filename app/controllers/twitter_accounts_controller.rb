# frozen_string_literal: true

class TwitterAccountsController < ApplicationController
  before_action :load_user
  before_action :load_twitter_account, only: %i[show edit update destroy]

  def index
    authorize TwitterAccount

    @twitter_accounts = scope
  end

  def callback
    authorize TwitterAccount
    redirect_to policy_scope(TwitterAccount).verify!(code: params[:code])
  end

  def show
  end

  def new
    @twitter_account = authorize policy_scope(TwitterAccount).new
  end

  def edit
  end

  def update
    if @twitter_account.update(twitter_account_params)
      redirect_to @twitter_account, notice: t(".notice")
    else
      flash.now.alert = @twitter_account.alert
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @twitter_account.destroy!

    redirect_to @twitter_account.user, notice: t(".notice")
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
      policy_scope(TwitterAccount).where(user: @user)
    else
      policy_scope(TwitterAccount)
    end
  end

  def id
    params[:twitter_account_id].presence || params[:id]
  end

  def load_twitter_account
    @twitter_account = authorize scope.find(id)
  end

  def twitter_account_params
    if admin?
      params.require(:twitter_account).permit(:user_id, :verified, :primary)
    else
      params.require(:twitter_account).permit(:primary)
    end
  end
end
