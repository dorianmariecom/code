# frozen_string_literal: true

Rails.application.routes.draw do
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
