Rails.application.routes.draw do
  resources :listings
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root 'home#page'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end