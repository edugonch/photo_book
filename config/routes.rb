Rails.application.routes.draw do
  devise_for :users
  root "home#index"

  resources :images

  get "users/profile", to: "users#profile"

  get "tags", to: "tags#index", as: :tags
end
