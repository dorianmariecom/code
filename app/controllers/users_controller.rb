class UsersController < ApplicationController
  before_action :load_user, only: [:show, :edit, :update, :destroy]

  def index
    authorize User
    @users = policy_scope(User)
  end

  def show
  end

  def new
    @user = authorize User.new
    build_user
  end

  def create
    @user = authorize User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: t(".notice")
    else
      build_user
      flash.now.alert = @user.alert
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    build_user
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: t(".notice")
    else
      build_user
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

  def build_user
    @user.email_addresses.build(primary: true) if @user.email_addresses.none?
  end

  def load_user
    @user = authorize policy_scope(User).find(params[:id])
  end

  def user_params
    params
      .require(:user)
      .permit(
        :time_zone,
        email_addresses_attributes: [
          :id,
          :_destroy,
          :primary,
          :email_address,
          :display_name,
          :smtp_address,
          :smtp_port,
          :smtp_user_name,
          :smtp_password,
          :smtp_authentication,
          :smtp_enable_starttls_auto
        ]
      )
  end
end
