class Flight < ApplicationRecord
  belongs_to :departure_airport, class_name: "Airport"
  # , foreign_key: "departure_airport_id"
  belongs_to :arrival_airport, class_name: "Airport"
  # , foreign_key: "arrival_airport_id"

  def duration
    duration = end_time - start_time
    duration.strftime("%l:%M%P")
  end


  def start_date_formatted
    start_time.strftime("%d/%m/%Y")
  end

end
