# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Healthcheck route
  get '/healthcheck', to: 'healthcheck#index'

  namespace :v1 do
    resources :jobs, only: [:index]
    resources :applications, only: [:index]
  end
end
