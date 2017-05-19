Rails.application.routes.draw do
    root to: 'visitors#index'
    devise_for :users
    resources :users
    
    post "/search/" => "search#index"

    resources :neighborhoods
    resources :userdata
    resources :search
    resources :reviews
    
    post "/search/show" => "search#show"
  end
