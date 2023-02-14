class Passenger < ApplicationRecord
  # has_many :bookings, :dependent => :delete_all
  belongs_to :bookings, inverse_of: :passenger, :dependent => :destroy
  has_many :flights, through: :bookings,  :dependent => :destroy


  # accepts_nested_attributes_for :bookings, allow_destroy: true
  
  validates :email, uniqueness: {case_sensitive: false}
end
