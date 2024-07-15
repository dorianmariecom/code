# frozen_string_literal: true

class ExecutionsController < ApplicationController
  before_action :load_user
  before_action :load_program
  before_action :load_execution, only: %i[show destroy]

  helper_method :url

  def index
    authorize Execution

    @executions = scope
  end

  def show
    @executions =
      policy_scope(Execution).where(execution: @execution).order(
        created_at: :desc
      )
  end

  def destroy
    @execution.destroy!

    redirect_to @execution.user, notice: t(".notice")
  end

  def destroy_all
    authorize Execution

    scope.destroy_all

    redirect_back_or_to(executions_path)
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
        @program =
          policy_scope(Program).where(user: @user).find(params[:program_id])
      else
        @program = policy_scope(Program).find(params[:program_id])
      end
    end
  end

  def scope
    if @user && @program
      policy_scope(Execution).joins(:program).where(
        program: {
          id: @program,
          user_id: @user.id
        }
      )
    elsif @user
      policy_scope(Execution).joins(:program).where(
        program: {
          user_id: @user.id
        }
      )
    elsif @program
      policy_scope(Execution).where(program: @program)
    else
      policy_scope(Execution)
    end
  end

  def url
    if @user && @program
      [@user, @program, :executions]
    elsif @user
      [@user, :executions]
    elsif @program
      [@program, :executions]
    else
      executions_path
    end
  end

  def id
    params[:execution_id].presence || params[:id]
  end

  def load_execution
    @execution = authorize scope.find(id)
  end
end
