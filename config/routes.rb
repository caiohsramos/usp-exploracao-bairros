Rails.application.routes.draw do
  resources :userdata
  root to: 'visitors#index'
  devise_for :users
  resources :users
  get "/search/index" => "search#index"
  get "/search/show" => "search#show", as: :search_show
  end
