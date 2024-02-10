# frozen_string_literal: true

class PasswordsController < ApplicationController
  before_action { authorize :password }
  skip_after_action :verify_policy_scoped

  def create
    result = PasswordValidator.check(params[:password])
    render json: { success: result.success?, message: result.message }
  end
end
