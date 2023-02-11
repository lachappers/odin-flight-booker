Rails.application.routes.draw do
  root "flights#index"

  get '/flights', to: "flights#index"

  # get 'bookings/new', to: "bookings#new"
  # get 'bookings/create', to: "bookings#new"
  # get '/bookings', to: "bookings#id"
  resources :bookings

  resources :flights
  # , only: [:index]
  # resources :bookings do
  #     resources :passengers
  #     resources :flights
  # end



  # resources :flights do

  # end
end
