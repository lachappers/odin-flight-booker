# == Schema Information
#
# Table name: bookings
#
#  id              :integer          not null, primary key
#  booking_ref     :string
#  passenger_count :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  flight_id       :integer
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
class Booking < ApplicationRecord
  # belongs_to : :passenger

  belongs_to :flight, inverse_of: :bookings
  has_many :passengers
  # pax id is fk for above

  validates :flight_id, presence: true

  accepts_nested_attributes_for :passengers, allow_destroy: true

  # after_initialize :set_booking_ref
  before_create :set_booking_ref

  def set_booking_ref
    self.booking_ref = generate_booking_ref
  end

  def generate_booking_ref
    loop do
      ref = 8.times.map { [*'1'..'9',*'A'..'N',*'P'..'W'].sample}.join
      break ref
        unless Booking.where(booking_ref: ref).exists?
      end
    end
  end



end
