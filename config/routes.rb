Rails.application.routes.draw do
  get 'home/index'

  root 'home#index'

  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :users, only: [:show]
  
end
