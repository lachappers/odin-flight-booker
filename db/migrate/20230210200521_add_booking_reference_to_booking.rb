class AddBookingReferenceToBooking < ActiveRecord::Migration[7.0]
  def change
    add_column :bookings, :booking_ref, :string
    add_index :bookings, :booking_ref
  end
end
