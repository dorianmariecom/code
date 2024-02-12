# frozen_string_literal: true

Rails.application.routes.draw do
  resources :password_validations

  resource :session

  resources :users do
    resources :email_addresses
    resources :passwords
    resources :programs
  end

  resources :email_addresses
  resources :passwords
  resources :programs

  get "up" => "pages#up"
  get "documentation" => "pages#documentation"

  root to: "pages#home"
end
