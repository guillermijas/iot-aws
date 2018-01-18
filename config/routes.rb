Rails.application.routes.draw do
  resources :logs
  resources :things
  devise_for :users

  root 'things#index'
end
