# frozen_string_literal: true

class AdminConstraints
  def matches?(request)
    User.find_by(id: request.session[:user_id])&.admin?
  end
end

Rails.application.routes.draw do
  default_url_options(host: ENV.fetch("BASE_URL"))

  constraints AdminConstraints.new do
    mount SolidErrors::Engine, at: "/errors", as: :errors
    mount MissionControl::Jobs::Engine, at: "/jobs", as: :jobs
  end

  resources :country_codes
  resources :password_validations
  resources :prompts

  resource :session

  resources :users do
    collection { delete "/" => "users#destroy_all" }

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

    resources :slack_accounts do
      collection { delete "/" => "slack_accounts#destroy_all" }
    end

    resources :x_accounts do
      collection { delete "/" => "x_accounts#destroy_all" }
      post "refresh_auth"
      post "refresh_me"
    end

    resources :passwords do
      collection { delete "/" => "passwords#destroy_all" }
    end

    resources :programs do
      collection { delete "/" => "programs#destroy_all" }
      post :evaluate
      post :schedule

      resources :executions do
        collection { delete "/" => "executions#destroy_all" }
      end

      resources :schedules do
        collection { delete "/" => "schedules#destroy_all" }
      end

      resources :prompts do
        collection { delete "/" => "prompts#destroy_all" }
      end
    end

    resources :data do
      collection { delete "/" => "data#destroy_all" }
    end

    resources :executions do
      collection { delete "/" => "executions#destroy_all" }
    end

    resources :schedules do
      collection { delete "/" => "schedules#destroy_all" }
    end

    resources :prompts do
      collection { delete "/" => "prompts#destroy_all" }
    end

    resources :locations do
      collection { delete "/" => "locations#destroy_all" }
    end

    resources :time_zones do
      collection { delete "/" => "time_zones#destroy_all" }
    end

    resources :names do
      collection { delete "/" => "names#destroy_all" }
    end
  end

  resources :guests do
    collection { delete "/" => "guests#destroy_all" }

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

    resources :slack_accounts do
      collection { delete "/" => "slack_accounts#destroy_all" }
    end

    resources :x_accounts do
      collection { delete "/" => "x_accounts#destroy_all" }
      post "refresh_auth"
      post "refresh_me"
    end

    resources :passwords do
      collection { delete "/" => "passwords#destroy_all" }
    end

    resources :locations do
      collection { delete "/" => "locations#destroy_all" }
    end

    resources :time_zones do
      collection { delete "/" => "time_zones#destroy_all" }
    end

    resources :names do
      collection { delete "/" => "names#destroy_all" }
    end

    resources :programs do
      collection { delete "/" => "programs#destroy_all" }
      post :evaluate
      post :schedule

      resources :executions do
        collection { delete "/" => "executions#destroy_all" }
      end

      resources :schedules do
        collection { delete "/" => "schedules#destroy_all" }
      end

      resources :prompts do
        collection { delete "/" => "prompts#destroy_all" }
      end
    end

    resources :data do
      collection { delete "/" => "data#destroy_all" }
    end

    resources :executions do
      collection { delete "/" => "executions#destroy_all" }
    end

    resources :schedules do
      collection { delete "/" => "schedules#destroy_all" }
    end

    resources :prompts do
      collection { delete "/" => "prompts#destroy_all" }
    end
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

  resources :slack_accounts do
    collection { delete "/" => "slack_accounts#destroy_all" }
  end

  resources :x_accounts do
    collection { delete "/" => "x_accounts#destroy_all" }
    post "refresh_auth"
    post "refresh_me"
  end

  resources :passwords do
    collection { delete "/" => "passwords#destroy_all" }
  end

  resources :programs do
    collection { delete "/" => "programs#destroy_all" }
    post :evaluate
    post :schedule

    resources :executions do
      collection { delete "/" => "executions#destroy_all" }
    end

    resources :schedules do
      collection { delete "/" => "schedules#destroy_all" }
    end

    resources :prompts do
      collection { delete "/" => "prompts#destroy_all" }
    end
  end

  resources :data do
    collection { delete "/" => "data#destroy_all" }
  end

  resources :executions do
    collection { delete "/" => "executions#destroy_all" }
  end

  resources :schedules do
    collection { delete "/" => "schedules#destroy_all" }
  end

  resources :prompts do
    collection { delete "/" => "prompts#destroy_all" }
  end

  resources :locations do
    collection { delete "/" => "locations#destroy_all" }
  end

  resources :time_zones do
    collection { delete "/" => "time_zones#destroy_all" }
  end

  resources :names do
    collection { delete "/" => "names#destroy_all" }
  end

  match "/auth/slack/callback" => "slack_accounts#callback",
        :via => %i[get post]
  match "/auth/x/callback" => "x_accounts#callback", :via => %i[get post]
  get "up" => "pages#up"
  get "more" => "pages#more"

  match "/404", to: "errors#not_found", via: :all
  match "/422", to: "errors#unprocessable_entity", via: :all
  match "/500", to: "errors#internal_server_error", via: :all

  root to: "pages#home"
end
