class PasswordsController < ApplicationController
  before_action :load_user
  before_action :load_password, only: [:show, :edit, :update, :destroy]

  def index
    authorize Password

    @passwords = scope
  end

  def show
  end

  def new
    @password = authorize scope.new
  end

  def create
    @password = authorize scope.new(password_params)

    if @password.save
      redirect_to @password, notice: t(".notice")
    else
      flash.now.alert = @password.alert
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @password.update(password_params)
      redirect_to @password, notice: t(".notice")
    else
      flash.now.alert = @password.alert
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @password.destroy!

    redirect_to @password.user, notice: t(".notice")
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
      policy_scope(Password).where(user: @user)
    else
      policy_scope(Password)
    end
  end

  def id
    params[:password_id].presence || params[:id]
  end

  def load_password
    @password = authorize scope.find(id)
  end

  def password_params
    if admin?
      params.require(:password).permit(:user_id, :password)
    else
      params.require(:password).permit(:password)
    end
  end
end
