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
  devise_for :users

  get 'home/index'
  get 'home/feel'
  get 'home/about_me'
  get 'home/call_back'
  root 'home#index'

  get 'home/jquery_mobile'
end
