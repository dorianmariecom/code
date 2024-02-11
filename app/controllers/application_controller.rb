# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization
  include CanConcern

  before_action :set_current_user
  after_action :verify_authorized
  after_action :verify_policy_scoped

  helper_method :current_user
  helper_method :current_user?
  helper_method :admin?
  helper_method :can?

  rescue_from Pundit::NotAuthorizedError do |error|
    redirect_to root_path, alert: error.message
  end

  def current_user
    Current.user
  end

  def current_user?
    !!current_user
  end

  def admin?
    current_user? && current_user.admin?
  end

  private

  def set_current_user
    return unless session[:user_id].present?

    Current.user = User.find_by(id: session[:user_id])

    reset_session if Current.user.nil?
  end
end
