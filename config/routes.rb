Mdh::Application.routes.draw do

  # Catch All
  match "/login", to: "sessions#new", as: "login", via: [:get]
  match "/logout", to: "sessions#destroy", as: "logout", via: [:get]
  match "/unauthorized", to: "sessions#unauthorized", as: "unauthorized", via: [:get]
  match "/dashboard", to: "my#dashboard", as: "dashboard", via: [:get]

  resources :sessions, only: [:new, :create, :destroy]

  # Administrative side
  namespace :admin do
    # Enable MailView, but only on admin side in dev environment
    if Rails.env.development?
      mount MailPreview => 'mail_view'
    end

    resources :articles do
      resources :comments, only: [:destroy]
      collection do
        match :calendar, via: [:get]
        match :tags, via: [:get]
        match "tags/:tag", to: "articles#tags", via: [:get], as: :tag
      end
    end
    resources :users
    root to: 'articles#index'
  end

  match "/register", to: "users#new", as: "register", via: [:get]
  resources :users, only: [:create, :destroy]

  resources :articles, only: [:index, :show] do
    resources :comments, except: [:index, :show]
    collection do
      match :calendar, via: [:get]
      match :tags, via: [:get], as: :tags
      match "tags/:tag", to: "articles#tags", via: [:get], as: :tag
    end
  end

  root to: 'articles#index'

  # The priority is based upon order of creation:
  # first created -> highest priority.
end
