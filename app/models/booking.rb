class Booking < ApplicationRecord
  belongs_to :passenger
  belongs_to :flight

  validates :flight_id, :passenger_id, presence: true

end
