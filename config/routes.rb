Rails.application.routes.draw do
  get 'home/index'
  get 'home/coming_soon'
  root 'home#coming_soon'

  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :users, only: [:show]


end
