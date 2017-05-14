Rails.application.routes.draw do
  resources :userdata
  root to: 'visitors#index'
  devise_for :users
  resources :users

  end
