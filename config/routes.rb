Rails.application.routes.draw do
  root "listings#index"
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  get 'listings/browse', to: 'categories#index'
  get 'listings/browse/:categories', to: 'categories#show'
  post 'listings/:id/track', to: 'listings#follow', as: 'follow_listing'
  post 'listings/:id/stop_tracking', to: 'listings#unfollow', as: 'unfollow_listing'
  resources :listings
  resources :addresses
    get 'addresses/index'

    get 'addresses/show'

    get 'addresses/new'

    get 'addresses/edit'

    get 'addresses/create'

    get 'addresses/update'

    get 'addresses/destroy'


end
