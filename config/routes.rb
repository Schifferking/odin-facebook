Rails.application.routes.draw do
  root 'posts#index'

  devise_for :users, controllers: { registrations: 'users/registrations' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :users, only: %i[index show]
  resources :posts, only: %i[new create index show]
  resources :likes, only: %i[new create]
  resources :comments, only: %i[new create]
  resources :relationships, only: %i[new create index update destroy]
end
