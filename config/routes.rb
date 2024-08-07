# frozen_string_literal: true

class AdminConstraints
  def matches?(request)
    User.find_by(id: request.session[:user_id])&.admin?
  end
end

Rails.application.routes.draw do
  define = -> do
    resources :programs do
      collection { delete "/" => "programs#destroy_all" }
      post :evaluate
      post :schedule
      delete "schedule" => "programs#unschedule"

      resources(:executions) do
        collection { delete "/" => "executions#destroy_all" }
      end

      resources(:schedules) do
        collection { delete "/" => "schedules#destroy_all" }
      end

      resources(:prompts) { collection { delete "/" => "prompts#destroy_all" } }
    end

    resources :email_addresses do
      collection { delete "/" => "email_addresses#destroy_all" }
      resource :verification_code
    end

    resources :phone_numbers do
      collection { delete "/" => "phone_numbers#destroy_all" }
      resource :verification_code
    end

    resources :smtp_accounts do
      collection { delete "/" => "smtp_accounts#destroy_all" }
      resource :verification_code
    end

    resources :x_accounts do
      collection { delete "/" => "x_accounts#destroy_all" }
      post "refresh_auth"
      post "refresh_me"
    end

    resources(:executions) do
      collection { delete "/" => "executions#destroy_all" }
    end

    resources(:slack_accounts) do
      collection { delete "/" => "slack_accounts#destroy_all" }
    end

    resources(:time_zones) do
      collection { delete "/" => "time_zones#destroy_all" }
    end

    resources(:locations) do
      collection { delete "/" => "locations#destroy_all" }
    end

    resources(:passwords) do
      collection { delete "/" => "passwords#destroy_all" }
    end

    resources(:schedules) do
      collection { delete "/" => "schedules#destroy_all" }
    end

    resources(:data) { collection { delete "/" => "data#destroy_all" } }
    resources(:devices) { collection { delete "/" => "devices#destroy_all" } }
    resources(:guests) { collection { delete "/" => "guests#destroy_all" } }
    resources(:names) { collection { delete "/" => "names#destroy_all" } }
    resources(:pages) { collection { delete "/" => "pages#destroy_all" } }
    resources(:prompts) { collection { delete "/" => "prompts#destroy_all" } }
    resources(:tokens) { collection { delete "/" => "tokens#destroy_all" } }
    resources(:users) { collection { delete "/" => "users#destroy_all" } }
  end

  default_url_options(host: ENV.fetch("BASE_URL"))

  constraints AdminConstraints.new do
    mount SolidErrors::Engine, at: "/errors", as: :errors
    mount MissionControl::Jobs::Engine, at: "/jobs", as: :jobs
  end

  resources(:guests, &define)
  resources(:users, &define)
  define.call

  resources :country_codes
  resources :password_validations
  resource :session

  match "/auth/slack/callback" => "slack_accounts#callback",
        :via => %i[get post]
  match "/auth/x/callback" => "x_accounts#callback", :via => %i[get post]
  get "up" => "static#up"
  get "about" => "static#about"
  get "terms" => "static#terms"
  get "privacy" => "static#privacy"
  get "source" => "static#source"

  match "/404", to: "errors#not_found", via: :all
  match "/422", to: "errors#unprocessable_entity", via: :all
  match "/500", to: "errors#internal_server_error", via: :all

  root to: "static#home"
end
