# frozen_string_literal: true

class PromptsController < ApplicationController
  before_action { authorize :prompt }
  skip_after_action :verify_policy_scoped

  def create
    render json: Prompt.generate(params[:prompt])
  end
end
