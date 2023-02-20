# == Schema Information
#
# Table name: passengers
#
#  id         :integer          not null, primary key
#  email      :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  booking_id :integer
#
# Indexes
#
#  index_passengers_on_booking_id  (booking_id)
#
# Foreign Keys
#
#  booking_id  (booking_id => bookings.id)
#
class Passenger < ApplicationRecord
  belongs_to :booking, dependent: :destroy
  has_many :flights, through: :booking, dependent: :destroy

  validates :email, :name, presence: true
  # validates :email, uniqueness: {case_sensitive: false}

  after_create :set_booking_pax

  private

  def set_booking_pax
    booking = self.booking
    booking.passenger_count = booking.passengers.count
  end
end
