Rails.application.routes.draw do
  # TODO: Probably need to change this when we update the donation application controller
  get 'donation_app_pdfs/show'
  get 'listings/browse', to: 'categories#index'
  get 'listings/browse/:categories', to: 'categories#show'
  resources :listings
  resources :addresses
    get 'addresses/index'

    get 'addresses/show'

    get 'addresses/new'

    get 'addresses/edit'

    get 'addresses/create'

    get 'addresses/update'

    get 'addresses/destroy'

  root "home#index"

  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
