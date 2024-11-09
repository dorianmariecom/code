# frozen_string_literal: true

class AdminConstraints
  def matches?(request)
    User.find_by(id: request.session[:user_id])&.admin?
  end
end

Rails.application.routes.draw do
  define =
    lambda do
      resources :programs do
        collection { delete "/", to: "programs#destroy_all" }
        post :evaluate
        post :schedule
        delete "schedule", to: "programs#unschedule"

        resources(:executions) do
          collection { delete "/", to: "executions#destroy_all" }
        end

        resources(:schedules) do
          collection { delete "/", to: "schedules#destroy_all" }
        end
      end

      resources :email_addresses do
        collection { delete "/", to: "email_addresses#destroy_all" }
        resource :verification_code
      end

      resources :phone_numbers do
        collection { delete "/", to: "phone_numbers#destroy_all" }
        resource :verification_code
      end

      resources(:executions) do
        collection { delete "/", to: "executions#destroy_all" }
      end

      resources(:time_zones) do
        collection { delete "/", to: "time_zones#destroy_all" }
      end

      resources(:locations) do
        collection { delete "/", to: "locations#destroy_all" }
      end

      resources(:passwords) do
        collection { delete "/", to: "passwords#destroy_all" }
      end

      resources(:schedules) do
        collection { delete "/", to: "schedules#destroy_all" }
      end

      resources(:data) { collection { delete "/", to: "data#destroy_all" } }
      resources(:devices) do
        collection { delete "/", to: "devices#destroy_all" }
      end
      resources(:guests) { collection { delete "/", to: "guests#destroy_all" } }
      resources(:names) { collection { delete "/", to: "names#destroy_all" } }
      resources(:pages) { collection { delete "/", to: "pages#destroy_all" } }
      resources(:tokens) { collection { delete "/", to: "tokens#destroy_all" } }
      resources(:users) { collection { delete "/", to: "users#destroy_all" } }
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

  get "up", to: "static#up"
  get "about", to: "static#about"
  get "terms", to: "static#terms"
  get "privacy", to: "static#privacy"
  get "source", to: "static#source"

  match "/404", to: "errors#not_found", via: :all
  match "/422", to: "errors#unprocessable_entity", via: :all
  match "/500", to: "errors#internal_server_error", via: :all

  root to: "programs#new"
end
