class RemovePassengerCountFromBooking < ActiveRecord::Migration[7.0]
  def change
    remove_column :bookings, :passenger_count, :integer
  end
end
