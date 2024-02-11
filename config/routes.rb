# frozen_string_literal: true

Rails.application.routes.draw do
  resources :password_validations

  resource :session

  resources :users do
    resources :email_addresses
    resources :passwords
  end

  resources :email_addresses
  resources :passwords

  get "up" => "pages#up"

  root to: "pages#home"
end
