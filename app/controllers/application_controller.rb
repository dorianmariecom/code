# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization
  include CanConcern

  protect_from_forgery with: :exception

  before_action :set_current_user
  after_action :verify_authorized
  after_action :verify_policy_scoped
  after_action :delete_link_header
  skip_after_action :verify_authorized, if: :mission_control_controller?
  skip_after_action :verify_policy_scoped, if: :mission_control_controller?

  helper_method :current_user
  helper_method :current_user?
  helper_method :admin?
  helper_method :can?

  rescue_from Pundit::NotAuthorizedError do |error|
    redirect_to root_path, alert: error.message
  end

  rescue_from ActiveRecord::RecordNotFound do |error|
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
    return if session[:user_id].blank?

    Current.user = User.find_by(id: session[:user_id])

    reset_session if Current.user.nil?
  end

  def delete_link_header
    response.headers.delete("Link")
  end

  def mission_control_controller?
    is_a?(::MissionControl::Jobs::ApplicationController)
  end
end
