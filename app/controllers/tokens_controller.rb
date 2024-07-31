# frozen_string_literal: true

class TokensController < ApplicationController
  before_action :load_user
  before_action :load_token, only: %i[show edit update destroy]

  helper_method :url

  def index
    authorize Token

    @tokens = scope.page(params[:page])
  end

  def show
  end

  def new
    @token = authorize scope.new
  end

  def create
    @token = authorize scope.new(token_params)

    if @token.save
      log_in(@token.user)
      redirect_to @token, notice: t(".notice")
    else
      flash.now.alert = @token.alert
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @token.update(token_params)
      log_in(@token.user)
      redirect_to @token, notice: t(".notice")
    else
      flash.now.alert = @token.alert
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @token.destroy!

    redirect_to url, notice: t(".notice")
  end

  def destroy_all
    authorize Token

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
    @user ? policy_scope(Token).where(user: @user) : policy_scope(Token)
  end

  def url
    @user ? [@user, :tokens] : tokens_path
  end

  def id
    params[:token_id].presence || params[:id]
  end

  def load_token
    @token = authorize scope.find(id)
  end

  def token_params
    params.require(:token).permit(:user_id, :token)
  end
end
