class UsersController < ApplicationController
  before_action :load_user, only: [:show, :edit, :update, :destroy]

  def index
    authorize User
    @users = policy_scope(User).order(:id)
  end

  def show
    @email_addresses = policy_scope(EmailAddress).where(user: @user)
    @passwords = policy_scope(Password).where(user: @user)
  end

  def new
    @user = authorize policy_scope(User).new
    build_user
  end

  def create
    @user = authorize policy_scope(User).new(user_params)

    if @user.save
      session[:user_id] = @user.id unless admin?
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
    @user.passwords.build if @user.passwords.none?
  end

  def load_user
    if params[:id] == "me"
      @user = authorize current_user
    else
      @user = authorize policy_scope(User).find(params[:id])
    end
  end

  def user_params
    if admin?
      params
        .require(:user)
        .permit(
          :admin,
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
          ],
          passwords_attributes: [
            :id,
            :_destroy,
            :password
          ]
        )
    else
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
          ],
          passwords_attributes: [
            :id,
            :_destroy,
            :password
          ]
        )
    end
  end
end
