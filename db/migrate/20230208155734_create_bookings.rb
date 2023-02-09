class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.belongs_to :passenger, foreign_key: true
      t.belongs_to :flight, foreign_key: true
      t.timestamps
    end
  end
end
