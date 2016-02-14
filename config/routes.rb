Rails.application.routes.draw do
  devise_for :users
  root "home#index"

  get "home", to: "home#index", as: :home

  resources :images

  get "users/profile/:id", to: "users#profile", as: 'profile'

  get "tags", to: "tags#index", as: :tags

  get "search", to: "images#search", as: :search
end
