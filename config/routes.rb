Rails.application.routes.draw do
  devise_for :users
  resources :logs, only: :index
  resources :things, only: :index

  get 'update_value/:id', to: 'things#update_value', as: 'update_value'

  root 'things#index'
end
