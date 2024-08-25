# frozen_string_literal: true

class ErrorsController < ApplicationController
  skip_after_action :verify_authorized
  skip_after_action :verify_policy_scoped

  def not_found
    @exception = request.env["action_dispatch.exception"]
    render status: :not_found
  end

  def internal_server_error
    @exception = request.env["action_dispatch.exception"]
    render status: :internal_server_error
  end

  def unprocessable_entity
    @exception = request.env["action_dispatch.exception"]
    render status: :unprocessable_entity
  end
end
