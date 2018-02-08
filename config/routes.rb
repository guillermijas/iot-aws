Rails.application.routes.draw do
  devise_for :users
  resources :logs, only: :index
  resources :things, only: :index

  get 'update_value/:id', to: 'things#update_value', as: 'update_value'
  post 'mode_on', to: 'things#mode_on', as: 'mode_on'
  post 'mode_off', to: 'things#mode_off', as: 'mode_off'
  post 'mode_presence', to: 'things#mode_presence', as: 'mode_presence'
  get 'reload_presence', to: 'things#reload_presence', as: 'reload_presence'

  root 'things#index'
end
