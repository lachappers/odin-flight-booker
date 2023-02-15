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
require "test_helper"

class FlightTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
