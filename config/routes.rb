Rails.application.routes.draw do
  namespace :account do
    resources :humen
  end
  # mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  namespace :admin do
    resources :users
  end

  namespace :account do
    get 'dashboard' => 'dashboard#index', as: 'dashboard'
    get 'unauthorized_error' => 'dashboard#unauthorized_error'
    resources :articles do
      collection do
        get "collections"
        get "calendar"
      end
    end

    resources :users do
      member do
        get 'edit_password'
        get 'edit_head'
        post 'update_head'
      end
    end

    resources :labels

    resources :humen do
      member do
        get :graphic
      end
    end
  end

  resources :articles do
    member do
      put 'vote'
      put 'collection'
      delete 'delete_vote'
      delete 'delete_collection'
    end
    collection do
      post 'preview'
    end
    resources :comments
  end

  resources :photos
  resources :notifications do
    collection do
      delete 'clean'
    end
  end

  get 'index' => 'home#index', as: 'home'
  get 'about_me' => 'home#about_me', controller: 'home'
  root 'home#index'

  #API
  mount ApiV1 => "/"
  mount GrapeSwaggerRails::Engine => '/swagger'

  devise_for :users, controllers: { sessions: 'sessions' }
  match "/404" => "errors#errors404", via: [:get, :post, :patch, :delete, :put]
  match "/422" => "errors#errors422", via: [:get, :post, :patch, :delete, :put]
  match "/500" => "errors#errors500", via: [:get, :post, :patch, :delete, :put]
end
