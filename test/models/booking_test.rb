# == Schema Information
#
# Table name: bookings
#
#  id          :integer          not null, primary key
#  booking_ref :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  flight_id   :integer
#
# Indexes
#
#  index_bookings_on_booking_ref  (booking_ref)
#  index_bookings_on_flight_id    (flight_id)
#
# Foreign Keys
#
#  flight_id  (flight_id => flights.id)
#
require "test_helper"

class BookingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
