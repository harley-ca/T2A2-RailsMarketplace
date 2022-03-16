Rails.application.routes.draw do
  resources :listings do
    resources :reviews, only:[:new, :create, :index, :edit, :destroy, :update, :show]
    resources :applications, only: [:new, :create, :update]
  end

  get '/my_listings', to: 'listings#my_listings', as: "my_listings"

  
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root 'home#page'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
