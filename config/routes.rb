Rails.application.routes.draw do
  devise_for :users
  resources :logs
  resources :things

  root 'things#index'
end
