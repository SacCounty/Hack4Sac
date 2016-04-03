Rails.application.routes.draw do
  root "listings#index"
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  post 'donation_applications/create'

  get 'listings/browse', to: 'categories#index'
  get 'listings/browse/:categories', to: 'categories#show'
  post 'listings/:id/track', to: 'listings#follow', as: 'follow_listing'
  post 'listings/:id/stop_tracking', to: 'listings#unfollow', as: 'unfollow_listing'
  resources :listings

  resources :users, only: [:show] do
    resources :addresses
    get '/donations', to: 'listings#donation_history'
    get '/requests', to: 'listings#request_history'
  end
end
