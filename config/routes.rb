Rails.application.routes.draw do
    root to: 'visitors#index'
    devise_for :users
    resources :users

    resources :neighborhoods
    resources :userdata
    resources :search
    
    get "/search/show" => "search#show"
  end
