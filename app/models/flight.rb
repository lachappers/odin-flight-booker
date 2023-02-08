class Flight < ApplicationRecord
  belongs_to :departure_airport, class_name: "Airport"
  belongs_to :arrival_airport, class_name: "Airport"
  
  validates :departure_airport_id, :arrival_airport_id, :start_date, :passenger_count, presence: true, on: :search

  scope :airport_options, -> { Airport.pluck(:name, :id) }

  # scope :date, -> {self.start_time.strftime("%d/%m/%Y")}

  # def self.date
  #   @date = self.start_time.strftime("%d/%m/%Y")
  # end

  # def flight_dates
  #   @flight_dates = @flights.map{|f| ("#{f.start_time.day.to_s.rjust(2,"0")}/#{f.start_time.month.to_s.rjust(2,"0")}/#{f.start_time.year}")}.uniq
  # end

  # def duration
  #   duration = self.end_time - self.start_time
  #   @duration = duration.strftime("%l:%M%P")
  # end


  # def start_date_formatted
  #   # @start_date_formatted = start_time.strftime("%d/%m/%Y")
  #   p start_date_tof
  # end
  # def start_date_tof
  #   start_time.strftime("%d/%m/%Y")
  # end


  # # def self.start_date_formatted
  # #   start_date_formatted = start_time.strftime("%d/%m/%Y")
  # # end

  # def start_time_formatted
  #   @start_time_formatted = start_time.strftime("%l:%M%P")
  # end
  # def airport_options
  #   Airport.pluck(:name, :id)
  # end




end

