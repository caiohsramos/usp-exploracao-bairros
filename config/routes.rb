Rails.application.routes.draw do
<<<<<<< HEAD
  resources :userdata
  root to: 'visitors#index'
  devise_for :users
  resources :users
  get "/search/index" => "search#index"
  get "/search/show" => "search#show", as: :search_show
=======
    root to: 'visitors#index'
    devise_for :users
    resources :users

    resources :neighborhoods
    resources :userdata
    resources :search
    
    get "/search/show" => "search#show"
>>>>>>> 0f21d66ee97c4806cdf50cffa42395ae55b6b8e0
  end
