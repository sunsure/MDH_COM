Mdh::Application.routes.draw do

  # Administrative side
  constraints(subdomain: /admin/) do
    scope module: "admin" do
      match "/login", to: "sessions#new", as: :admin_login, via: [:get]
      match "/logout", to: "sessions#destroy", as: :admin_logout, via: [:get]
      match "/unauthorized", to: "sessions#unauthorized", as: :admin_unauthorized, via: [:get]
      match "/dashboard", to: "my#dashboard", as: :admin_dashboard, via: [:get]

      resources :sessions, only: [:new, :create, :destroy]

      resources :articles do
        collection do
          match :tags, via: [:get], as: :admin_tags
          match "tags/:tag", to: "articles#tags", via: [:get], as: :admin_tag
        end
      end
      resources :users
      root to: 'articles#index'
    end
  end

  constraints(subdomain: /www/) do
    match "/login", to: "sessions#new", as: "login", via: [:get]
    match "/logout", to: "sessions#destroy", as: "logout", via: [:get]
    match "/unauthorized", to: "sessions#unauthorized", as: "unauthorized", via: [:get]
    match "/dashboard", to: "my#dashboard", as: "dashboard", via: [:get]

    resources :sessions, only: [:new, :create, :destroy]

    match "/register", to: "users#new", as: "register", via: [:get]
    resources :users, only: [:create, :destroy]

    resources :articles, only: [:index, :show] do
      collection do
        match :tags, via: [:get], as: :tags
        match "tags/:tag", to: "articles#tags", via: [:get], as: :tag
      end
    end

    root to: 'articles#index'
  end

  # The priority is based upon order of creation:
  # first created -> highest priority.
end
