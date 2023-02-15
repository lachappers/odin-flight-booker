class AddBookingIdToPassengers < ActiveRecord::Migration[7.0]
  def change
    add_reference :passengers, :booking, foreign_key: true, index: true
  end
end
