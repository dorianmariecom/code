# frozen_string_literal: true

class AdminConstraints
  def matches?(request)
    User.find_by(id: request.session[:user_id])&.admin?
  end
end

Rails.application.routes.draw do
  constraints AdminConstraints.new do
    mount SolidErrors::Engine, at: "/errors", as: :errors
  end

  resources :country_codes
  resources :password_validations
  resources :prompts

  resource :session

  resources :users do
    resources :email_addresses
    resources :phone_numbers
    resources :passwords
    resources :programs
  end

  resources :email_addresses
  resources :phone_numbers
  resources :passwords
  resources :programs

  get "up" => "pages#up"
  get "documentation" => "pages#documentation"

  root to: "pages#home"
end
