Mdh::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.
  scope module: "sessions" do
    match :new, as: :login, via: [:get], path: "/login"
    match :create, via: [:post], path: "/login"
    match :destroy, as: :logout, via: [:get], path: "/logout"
    match :unauthorized, as: :unauthorized, via: [:get], path: "/unauthorized"
    match :confirm_account, as: :confirm_account, via: [:get], path: "/confirm_account/:auth_token"
  end

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

  scope module: "users" do
    match :new, via: [:get], as: :register, path: "/register"
  end
  resources :users, only: [:create, :destroy]

  # Make sure not to move these two around...order matters!
  scope module: "users/confirm" do
    match :create, via: [:post], as: :confirm_create, path: "/confirm"
  end
  resources :confirm, only: [:edit, :update], to: "users/confirm"

  resource :my, only: [:dashboard, :comments, :inbox], to: "my" do
    match :comments, via: [:get]
    match :dashboard, via: [:get]
    match :inbox,via: [:get]
    resource :profile, only: [:edit, :update]
  end

  resources :articles, only: [:index, :show] do
    resources :comments, except: [:index, :show, :destroy] do
      member do
        match :reply, to: "comments#new_reply", via: [:get]
        match :reply, to: "comments#reply", via: [:post]
      end
    end
    collection do
      match :calendar, via: [:get]
      match :tags, via: [:get], as: :tags
      match "tags/:tag", to: "articles#tags", via: [:get], as: :tag
    end
  end

  # Root path
  root to: 'articles#index'
end
