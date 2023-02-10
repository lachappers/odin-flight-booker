class Passenger < ApplicationRecord
  has_many :bookings, :dependent => :delete_all
  has_many :flights, through: :bookings, :dependent => :delete_all

  accepts_nested_attributes_for :bookings, allow_destroy: true
  
  validates :email, uniqueness: {case_sensitive: false}
end
