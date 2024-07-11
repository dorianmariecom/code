# frozen_string_literal: true

class ProgramsController < ApplicationController
  before_action :load_user
  before_action :load_program, only: %i[show edit update destroy]

  helper_method :url

  def index
    authorize Program

    @programs = scope
  end

  def show
  end

  def new
    @program = authorize scope.new
  end

  def create
    unless current_user
      Current.user = User.create!
      session[:user_id] = Current.user.id
    end

    @program = authorize scope.new(program_params)

    if @program.save
      @program.evaluate!
      redirect_to @program, notice: t(".notice")
    else
      flash.now.alert = @program.alert
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @program.update(program_params)
      @program.evaluate!
      redirect_to @program, notice: t(".notice")
    else
      flash.now.alert = @program.alert
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @program.destroy!

    redirect_to @program.user, notice: t(".notice")
  end

  def destroy_all
    authorize Program

    scope.destroy_all

    redirect_back_or_to(programs_path)
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
    @user ? policy_scope(Program).where(user: @user) : policy_scope(Program)
  end

  def url
    @user ? [@user, :programs] : programs_path
  end

  def id
    params[:program_id].presence || params[:id]
  end

  def load_program
    @program = authorize scope.find(id)
  end

  def program_params
    if admin?
      params.require(:program).permit(:user_id, :input, :name, :prompt)
    else
      params.require(:program).permit(:input, :name, :prompt)
    end
  end
end
