Rails.application.routes.draw do
  # mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  namespace :admin do
    resources :users
  end

  namespace :account do
    get 'dashboard' => 'dashboard#index', as: 'dashboard'
    resources :articles

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
    end
    collection do
      post 'preview'
    end
    resources :comments
  end

  resources :photos
  devise_for :users

  get 'home/index'
  get 'home/feel'
  get 'home/about_me'
  get 'home/call_back'
  root 'home#index'

  get 'home/jquery_mobile'
end
