# frozen_string_literal: true

Rails.application.routes.draw do
  get "up" => "pages#up"

  root to: "pages#home"
end
