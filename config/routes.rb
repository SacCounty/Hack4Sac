Rails.application.routes.draw do
  root "listings#index"

  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)


  get 'listings/browse', to: 'categories#index'
  post 'listings/:id/track', to: 'listings#follow', as: 'follow_listing'
  post 'listings/:id/stop_tracking', to: 'listings#unfollow', as: 'unfollow_listing'
  post 'listings/:id/donation_applications', to: 'donation_applications#create', as: 'create_application'
  resources :listings

  resources :users, only: [:show] do
    resources :addresses
    get '/donations', to: 'listings#donation_history'
    get '/requests', to: 'listings#request_history'
  end
end
