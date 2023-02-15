class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.belongs_to :flight, foreign_key: true
      t.integer :passenger_count
      t.timestamps
    end
  end
end
