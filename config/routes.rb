Rails.application.routes.draw do

  namespace :admin do
    resources :users
  end

  namespace :account do 
    get 'dashboard' => 'dashboard#index', as: 'dashboard'
    resources :articles

    resources :users
  end

  resources :articles do 
    resources :comments
  end
  devise_for :users

  get 'home/index'
  get 'home/feel'
  get 'home/about_me'
  root 'home#index'
end
