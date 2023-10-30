Rails.application.routes.draw do
  resources :posts
  resources :analytics

  root "posts#index"
end