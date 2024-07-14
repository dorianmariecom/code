# frozen_string_literal: true

class SchedulesController < ApplicationController
  before_action :load_user
  before_action :load_program
  before_action :load_schedule, only: %i[show edit update destroy]

  helper_method :url

  def index
    authorize Schedule

    @schedules = scope
  end

  def show
    @schedules =
      policy_scope(Schedule).where(schedule: @schedule).order(created_at: :desc)
  end

  def new
    @schedule = authorize scope.new
  end

  def create
    @schedule = authorize scope.new(schedule_params)

    if @schedule.save
      redirect_to @schedule, notice: t(".notice")
    else
      flash.now.alert = @schedule.alert
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @schedule.update(schedule_params)
      redirect_to @schedule, notice: t(".notice")
    else
      flash.now.alert = @schedule.alert
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @schedule.destroy!

    redirect_to @schedule.user, notice: t(".notice")
  end

  def destroy_all
    authorize Schedule

    scope.destroy_all

    redirect_back_or_to(schedules_path)
  end

  private

  def load_user
    if params[:user_id] == "me"
      @user = current_user
    elsif params[:user_id].present?
      @user = policy_scope(User).find(params[:user_id])
    end
  end

  def load_program
    if params[:program_id].present?
      if @user
        @program = policy_scope(Program).where(user: @user).find(params[:program_id])
      else
        @program = policy_scope(Program).find(params[:program_id])
      end
    end
  end

  def scope
    if @user && @program
      policy_scope(Schedule)
        .joins(:program)
        .where(program: { id: @program, user_id: @user.id })
    elsif @user
      policy_scope(Schedule).joins(:program).where(program: { user_id: @user.id })
    elsif @program
      policy_scope(Schedule).where(program: @program)
    else
      policy_scope(Schedule)
    end
  end

  def url
    if @user && @program
      [@user, @program, :schedules]
    elsif @user
      [@user, :schedules]
    elsif @program
      [@program, :schedules]
    else
      schedules_path
    end
  end

  def id
    params[:schedule_id].presence || params[:id]
  end

  def load_schedule
    @schedule = authorize scope.find(id)
  end

  def schedule_params
    params.require(:schedule).permit(:program_id, :starts_at, :interval)
  end
end
