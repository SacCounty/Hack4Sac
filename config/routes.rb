Rails.application.routes.draw do
  get 'donation_app_pdfs/show'

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
