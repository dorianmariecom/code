# frozen_string_literal: true

class DataController < ApplicationController
  before_action :load_user
  before_action :load_datum, only: %i[show edit update destroy]
  helper_method :url
  helper_method :new_url

  def index
    authorize Datum

    @data = scope.page(params[:page])
    @breadcrumbs = [@user, :data]
  end

  def show
    @breadcrumbs = [@user, @datum]
  end

  def new
    @datum = authorize scope.new
    @breadcrumbs = [@user, @datum, :new]
  end

  def edit
    @breadcrumbs = [@user, @datum, :edit]
  end

  def create
    datum_params[:data] = JSON.parse(data_param) if data_param.present?

    @datum = authorize scope.new(datum_params)

    if @datum.save
      log_in(@datum.user)
      redirect_to @datum, notice: t(".notice")
    else
      flash.now.alert = @datum.alert
      render :new, status: :unprocessable_entity
    end
  end

  def update
    datum_params[:data] = JSON.parse(data_param) if data_param.present?

    if @datum.update(datum_params)
      log_in(@datum.user)
      redirect_to @datum, notice: t(".notice")
    else
      flash.now.alert = @datum.alert
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @datum.destroy!

    redirect_to url, notice: t(".notice")
  end

  def destroy_all
    authorize Datum

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
    @user ? policy_scope(Datum).where(user: @user) : policy_scope(Datum)
  end

  def url
    @user ? [@user, :data] : data_path
  end

  def new_url
    @user ? [:new, @user, :datum] : %i[new datum]
  end

  def id
    params[:datum_id].presence || params[:id]
  end

  def load_datum
    @datum = authorize scope.find(id)
  end

  def datum_params
    @datum_params ||= params.require(:datum).permit(:user_id, :data)
  end

  def data_param
    datum_params[:data]
  end
end
