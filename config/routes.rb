Rails.application.routes.draw do
  # mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  namespace :admin do
    resources :users
  end

  namespace :account do
    get 'dashboard' => 'dashboard#index', as: 'dashboard'
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
  devise_for :users, controllers: { sessions: 'sessions' }

  get 'index' => 'home#index', as: 'home'
  get 'about_me' => 'home#about_me', controller: 'home'
  root 'home#index'

  get 'home/jquery_mobile'


  #API
  mount ApiV1 => "/"
  mount GrapeSwaggerRails::Engine => '/swagger'
end
