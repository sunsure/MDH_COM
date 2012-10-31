Mdh::Application.routes.draw do

  get "/login", to: "sessions#new", as: "login"
  get "/logout", to: "sessions#destroy", as: "logout"
  get "/unauthorized", to: "sessions#unauthorized", as: "unauthorized"
  get "/dashboard", to: "my#dashboard", as: "dashboard"

  resources :sessions, only: [:new, :create, :destroy]

  constraints(subdomain: /admin/) do
    scope module: "admin" do
      resources :articles
      resources :users
      root to: 'articles#index'
    end
  end

  match "/register", to: "users#new", as: "register", via: [:get]
  resources :users, only: [:create, :destroy]

  resources :articles, only: [:index, :show]
  root to: 'articles#index'

  # The priority is based upon order of creation:
  # first created -> highest priority.
end
