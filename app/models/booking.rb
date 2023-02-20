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
class Booking < ApplicationRecord
  belongs_to :flight, inverse_of: :bookings
  has_many :passengers

  validates :flight_id, presence: true
  validate :require_one_passenger
  # validates :passengers_attributes, presence: true


  accepts_nested_attributes_for :passengers, allow_destroy: true, reject_if: proc { |attr| attr['name'].blank? || attr['email'].blank? }

  before_create :set_booking_ref
  # after_create :update_pax

  private
  
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

  def require_one_passenger
    errors.add(:base, "You must provide details for at least 1 passenger") if passengers.size < 1
  end

  # def  update_pax
  #   @booking.passenger_count = @booking.passengers.count
  # end

end
