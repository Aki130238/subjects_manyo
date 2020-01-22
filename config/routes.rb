Rails.application.routes.draw do
  get 'sessions/new'
  root to: "tasks#index"
  resources :tasks
  resources :sessions, only: [:index, :new, :create, :destroy]
  resources :users
  namespace :admin do
    resources :users
  end
  resources :conversations do
    resources :messages
  end
end
