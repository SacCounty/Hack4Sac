Rails.application.routes.draw do
  root "home#index"
	resources :listings do
    resources :categories, only: [:show]
  end

  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
