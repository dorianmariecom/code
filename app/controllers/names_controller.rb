# frozen_string_literal: true

class NamesController < ApplicationController
  before_action :load_user
  before_action :load_name, only: %i[show edit update destroy]

  helper_method :url

  def index
    authorize Name

    @names = scope
  end

  def show
  end

  def new
    @name = authorize scope.new
  end

  def create
    @name = authorize scope.new(name_params)

    if @name.save
      redirect_to @name, notice: t(".notice")
    else
      flash.now.alert = @name.alert
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @name.update(name_params)
      redirect_to @name, notice: t(".notice")
    else
      flash.now.alert = @name.alert
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @name.destroy!

    redirect_to @name.user, notice: t(".notice")
  end

  def destroy_all
    authorize Name

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
    @user ? policy_scope(Name).where(user: @user) : policy_scope(Name)
  end

  def url
    @user ? [@user, :names] : names_path
  end

  def id
    params[:name_id].presence || params[:id]
  end

  def load_name
    @name = authorize scope.find(id)
  end

  def name_params
    if admin?
      params.require(:name).permit(:user_id, :primary, :verified, :name)
    else
      params.require(:name).permit(:user_id, :primary, :name)
    end
  end
end
