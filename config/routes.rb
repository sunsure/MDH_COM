Mdh::Application.routes.draw do

  get "/login", to: "sessions#new", as: "login"
  get "/logout", to: "sessions#destroy", as: "logout"
  get "/unauthorized", to: "sessions#unauthorized", as: "unauthorized"
  get "/dashboard", to: "my#dashboard", as: "dashboard_path"

  resources :articles
  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  root to: 'articles#index'

  # The priority is based upon order of creation:
  # first created -> highest priority.
end
