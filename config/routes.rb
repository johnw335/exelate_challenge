Rails.application.routes.draw do
  resources :users
  resources :favorites
  resources :sessions
  resources :transportations
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root 'transportations#index'
  get 'users/login'
  post 'users/login'
  # get 'transportations/index'
  # post 'transportations/index'
  post 'transportations/display'
  post 'favorites/destroy'
  post 'sessions/destroy'
  root 'users#new'
end
