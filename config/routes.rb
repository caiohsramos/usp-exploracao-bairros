Rails.application.routes.draw do
    root to: 'visitors#index'
    devise_for :users

    resources :users do
        get 'notifications'
    end

    resources :userdata
    resources :search
    resources :reviews

    match 'search' => 'search#index', via: 'post'
    match 'search/show/' => 'search#show', as: :search_show, via: 'get'
    match 'user/:id' => 'users#destroy', as: :destroy_user, via: 'delete'
    match 'user/:id/add_friend' => 'users#add_friend', as: :add_friend, via: 'get'
    match 'user/:id/accept_friend' => 'users#accept_friend', as: :accept_friend, via: 'get'
    match 'user/friends' => 'users#friends', as: :friends, via: 'get'
    match 'user/cancel_friend' => 'users#cancel_friend', as: :cancel_friend, via: 'delete'
    match 'user/cancel_request' => 'users#cancel_request', as: :cancel_request, via: 'delete'
end
