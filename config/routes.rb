# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :v1 do
    resources :categories, defaults: { format: :json }
    resources :recipes, defaults: { format: :json }
    resources :users, defaults: { format: :json }
    resources :sessions, defaults: { format: :json }, only: [:create]
    get "/profile/me", to: "profiles#show", defaults: { format: :json }
  end
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  get "up" => "rails/health#show", as: :rails_health_check
end
