# == Schema Information
#
# Table name: flights
#
#  id                   :integer          not null, primary key
#  end_time             :datetime
#  start_time           :datetime
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  arrival_airport_id   :integer          not null
#  departure_airport_id :integer          not null
#
# Indexes
#
#  index_flights_on_arrival_airport_id    (arrival_airport_id)
#  index_flights_on_departure_airport_id  (departure_airport_id)
#
# Foreign Keys
#
#  arrival_airport_id    (arrival_airport_id => airports.id)
#  departure_airport_id  (departure_airport_id => airports.id)
#
class Flight < ApplicationRecord
  belongs_to :departure_airport, class_name: "Airport"
  belongs_to :arrival_airport, class_name: "Airport"
  
  has_many :bookings, dependent: :delete_all, inverse_of: :flight
  has_many :passengers, through: :bookings, :dependent => :destroy
  
  #  ? below why?
  accepts_nested_attributes_for :bookings
  
  # validates :departure_airport_id, :arrival_airport_id, :start_date
  validates :passenger_count, presence: true, on: :flight_search

  validates_associated :bookings

  scope :airport_options, -> { Airport.pluck(:name, :id) }

  


end

