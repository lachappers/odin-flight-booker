class Airport < ApplicationRecord
  has_many :departing_flights, foreign_key: "departure_airport_id", class_name: "Flight", inverse_of: :departure_airport
  has_many :arriving_flights, foreign_key: "arrival_airport_id", class_name: "Flight", inverse_of: :arrival_airport
end
