# frozen_string_literal: true

class ProgramsController < ApplicationController
  before_action :load_user
  before_action :load_program,
                only: %i[show edit update destroy evaluate schedule]

  helper_method :url

  def index
    authorize Program

    @programs = scope
  end

  def show
    @executions =
      policy_scope(Execution).where(program: @program).order(created_at: :desc)
    @schedules =
      policy_scope(Schedule).where(program: @program).order(created_at: :desc)
    @prompts =
      policy_scope(Prompt).where(program: @program).order(created_at: :desc)
  end

  def evaluate
    @program.evaluate!

    redirect_back_or_to(@program)
  end

  def schedule
    @program.schedule!

    redirect_back_or_to(@program)
  end

  def new
    @program = authorize scope.new
  end

  def create
    Current.user = User.create! if Current.guest?
    session[:user_id] = Current.user.id

    @program = authorize scope.new(program_params)

    if @program.save
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
      redirect_to @program, notice: t(".notice")
    else
      flash.now.alert = @program.alert
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @program.destroy!

    redirect_to url, notice: t(".notice")
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
    params.require(:program).permit(
      :user_id,
      :input,
      :prompt,
      schedules_attributes: %i[id _destroy starts_at interval]
    )
  end
end
