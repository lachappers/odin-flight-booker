Rails.application.routes.draw do
  get 'bookings/new', to: "bookings#new"
  # get 'bookings/create', to: "bookings#new"
  # get 'bookings/show'
  
  root "flights#index"
  resources :flights, only: [:index]
  resources :bookings

  get '/flights', to: "flights#index"

  # resources :flights do

  # end
end
