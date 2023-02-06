class CreateFlights < ActiveRecord::Migration[7.0]
  def change
    create_table :flights do |t|
      t.references :departure_airport, null: false, foreign_key: false
      t.references :arrival_airport, null: false, foreign_key: false
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
    add_foreign_key :flights, :airports, column: :departure_airport_id
    add_foreign_key :flights, :airports, column: :arrival_airport_id
  end
end
