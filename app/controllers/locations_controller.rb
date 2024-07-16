# frozen_string_literal: true

class LocationsController < ApplicationController
  before_action :load_user
  before_action :load_location, only: %i[show edit update destroy]

  helper_method :url

  def index
    authorize Location

    @locations = scope
  end

  def show
  end

  def new
    @location = authorize scope.new
  end

  def create
    @location = authorize scope.new(location_params)

    if @location.save
      redirect_to @location, notice: t(".notice")
    else
      flash.now.alert = @location.alert
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @location.update(location_params)
      redirect_to @location, notice: t(".notice")
    else
      flash.now.alert = @location.alert
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @location.destroy!

    redirect_to @location.user, notice: t(".notice")
  end

  def destroy_all
    authorize Location

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
    @user ? policy_scope(Location).where(user: @user) : policy_scope(Location)
  end

  def url
    @user ? [@user, :locations] : locations_path
  end

  def id
    params[:location_id].presence || params[:id]
  end

  def load_location
    @location = authorize scope.find(id)
  end

  def location_params
    if admin?
      params.require(:name).permit(:user_id, :primary, :verified, :location)
    else
      params.require(:name).permit(:user_id, :primary, :location)
    end
  end
end
