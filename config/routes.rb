Rails.application.routes.draw do
<<<<<<< HEAD
    root to: 'visitors#index'
    
    devise_for :users
    resources :users
    
    resources :neighborhoods
    
end
=======
  resources :userdata
  root to: 'visitors#index'
  devise_for :users
  resources :users
  get "/search/index" => "search#index"
  get "/search/show" => "search#show"
  end
>>>>>>> ea760f78acb19afd1d9b0ddccaa4592d48db1e3b
