class Passenger < ApplicationRecord
  has_many :bookings, :dependent => :delete_all
  has_many :flights, through: :bookings, :dependent => :delete_all

  validates :email, uniqueness: {case_sensitive: false}
end
