Rails.application.routes.draw do
  root "users#index"

  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :users, only: [:index, :show]
  resources :posts, only: [:new, :create, :index, :show]
  resources :likes, only: [:new, :create]
  resources :comments, only: [:new, :create]
end
