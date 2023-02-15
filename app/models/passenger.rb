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
  # has_many :bookings, :dependent => :delete_all
  belongs_to :booking, :dependent => :destroy
  has_many :flights, through: :booking,  :dependent => :destroy


  # accepts_nested_attributes_for :bookings, allow_destroy: true
  
  validates :email, uniqueness: {case_sensitive: false}
end
