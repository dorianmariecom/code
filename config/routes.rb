# frozen_string_literal: true

Rails.application.routes.draw do
  resource :session
  resource :password
  resources :users

  get "up" => "pages#up"

  root to: "pages#home"
end
