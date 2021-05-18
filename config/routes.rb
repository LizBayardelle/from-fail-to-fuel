Rails.application.routes.draw do
  get 'home/index'
  get 'home/coming_soon'
  root 'home#coming_soon'

  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :users, only: [:show]

  resources :contacts
  post "contacts/:id/mark_responded" => "contacts#mark_responded", as: "mark_responded"
  post "contacts/:id/mark_unresponded" => "contacts#mark_unresponded", as: "mark_unresponded"
  post "contacts/:id/mark_archived" => "contacts#mark_archived", as: "mark_archived"
  post "contacts/:id/mark_unarchived" => "contacts#mark_unarchived", as: "mark_unarchived"

end
