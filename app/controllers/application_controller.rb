# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :set_current_user
  after_action :verify_authorized
  after_action :verify_policy_scoped

  helper_method :current_user

  def current_user
    Current.user
  end

  private

  def set_current_user
    return unless session[:user_id].present?

    Current.user = User.find_by(id: session[:user_id])

    reset_session if Current.user.nil?
  end
end
