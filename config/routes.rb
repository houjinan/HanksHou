Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  namespace :admin do
    resources :users
  end

  namespace :account do
    get 'dashboard' => 'dashboard#index', as: 'dashboard'
    resources :articlesroutes

    resources :users
  end

  resources :articles do
    resources :comments
  end
  devise_for :users

  get 'home/index'
  get 'home/feel'
  get 'home/about_me'
  get 'home/call_back'
  root 'home#index'

  get 'home/jquery_mobile'
end
