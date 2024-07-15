# frozen_string_literal: true

class PromptsController < ApplicationController
  before_action :load_user
  before_action :load_program
  before_action :load_prompt, only: %i[show destroy]

  helper_method :url

  def index
    authorize Prompt

    @prompts = scope
  end

  def show
    @prompts =
      policy_scope(Prompt).where(prompt: @prompt).order(created_at: :desc)
  end

  def create
    @prompt = authorize policy_scope(Prompt).new(prompt_params)

    if @prompt.save
      @prompt.generate!

      render json: { prompt: { input: @prompt.input } }
    else
      render json: { alert: @prompt.alert }, status: :unprocessable_entity
    end
  end

  def destroy
    @prompt.destroy!

    redirect_to @prompt.user, notice: t(".notice")
  end

  def destroy_all
    authorize Prompt

    scope.destroy_all

    redirect_back_or_to(prompts_path)
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
      policy_scope(Prompt)
        .joins(:program)
        .where(program: { id: @program, user: @user })
        .or(
          policy_scope(Prompt).joins(:program).where(
            user: @user,
            program: @program
          )
        )
    elsif @user
      policy_scope(Prompt)
        .left_joins(:program)
        .where(user: @user)
        .or(
          policy_scope(Prompt).left_joins(:program).where(
            programs: {
              user: @user
            }
          )
        )
    elsif @program
      policy_scope(Prompt).where(program: @program)
    else
      policy_scope(Prompt)
    end
  end

  def url
    if @user && @program
      [@user, @program, :prompts]
    elsif @user
      [@user, :prompts]
    elsif @program
      [@program, :prompts]
    else
      prompts_path
    end
  end

  def id
    params[:prompt_id].presence || params[:id]
  end

  def load_prompt
    @prompt = authorize scope.find(id)
  end

  def prompt_params
    params.require(:prompt).permit(:user_id, :program_id, :prompt)
  end
end
