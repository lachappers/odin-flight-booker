class Booking < ApplicationRecord
  # belongs_to : :passenger
  has_many :passengers
  belongs_to :flight

  validates :flight_id, :passenger_id, presence: true

  accepts_nested_attributes_for :passengers, allow_destroy: true

  after_initialize :set_booking_ref
  # before_create :set_booking_ref

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
