# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization
  include CanConcern

  protect_from_forgery with: :exception
  skip_forgery_protection if: :current_token?

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
    Current.user_or_guest
  end

  def current_user?
    !!current_user
  end

  def admin?
    current_user? && current_user.admin?
  end

  private

  def set_current_user
    log_in(current_user_from_session || current_token&.user)
  end

  def log_in(user)
    if Current.user && session[:user_id].present?
      # leave it as is
    elsif user&.id
      Current.user = user
      session[:user_id] = user.id
    else
      Current.user = nil
      session[:user_id] = nil
    end
  end

  def delete_link_header
    response.headers.delete("Link")
  end

  def mission_control_controller?
    is_a?(::MissionControl::Jobs::ApplicationController)
  end

  def current_user_from_session
    session[:user_id].present? ? User.find_by(id: session[:user_id]) : nil
  end

  def current_token
    return if request.headers[:Token].blank?

    Token.find_by(token: request.headers[:Token])
  end

  def current_token?
    !!current_token
  end
end
