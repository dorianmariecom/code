# frozen_string_literal: true

class DevicesController < ApplicationController
  before_action :load_user
  before_action :load_device, only: %i[show edit update destroy]

  helper_method :url

  def index
    authorize Device

    @breadcrumbs = [@user, :devices]
    @devices = scope.page(params[:page])
  end

  def show
    @breadcrumbs = [@user, @device]
  end

  def new
    @device = authorize scope.new
    @breadcrumbs = [@user, @device, :new]
  end

  def create
    @device = authorize scope.new(device_params)

    if @device.save
      log_in(@device.user)
      redirect_to @device, notice: t(".notice")
    else
      flash.now.alert = @device.alert
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @breadcrumbs = [@user, @device, :edit]
  end

  def update
    if @device.update(device_params)
      log_in(@device.user)
      redirect_to @device, notice: t(".notice")
    else
      flash.now.alert = @device.alert
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @device.destroy!

    redirect_to url, notice: t(".notice")
  end

  def destroy_all
    authorize Device

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
    @user ? policy_scope(Device).where(user: @user) : policy_scope(Device)
  end

  def url
    @user ? [@user, :devices] : devices_path
  end

  def id
    params[:device_id].presence || params[:id]
  end

  def load_device
    @device = authorize scope.find(id)
  end

  def device_params
    params.require(:device).permit(:user_id, :token, :platform)
  end
end
