Rails.application.routes.draw do
  resources :listings do
    resources :reviews, only:[:new, :create, :index, :edit, :destroy, :update, :show]
    patch 'applications/:id/update', to: "applications#update_app", as: "update_app"
    resources :applications, only: [:new, :create]
  end

  resources :applications, only: [:edit, :update, :my_apps]

  get '/my_listings', to: 'listings#my_listings', as: "my_listings"
  get '/my_apps', to: 'applications#my_apps', as: "my_apps"
  patch '/listings/:id/update', to: "listings#update_listing", as: "update_listing"


  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root 'home#page'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
