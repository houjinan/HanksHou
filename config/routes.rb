Rails.application.routes.draw do
  resources :articles
  devise_for :users

  
  get 'home/index'
  get 'home/feel'
  get 'home/about_me'
  root 'home#index'
end
