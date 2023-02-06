class FlightsController < ApplicationController
  def index


    @airport_options = Airport.all.map{ |a| [a.name, a.id]}

    # @available_flight_dates = (@flights.map { |f| f.start_date_formatted }).uniq
    if params[:departure_airport]="" && params[:arrival_airport]=""
      @flights = Flight.all.order(start_time: :asc)
      @available_flight_dates = (@flights.map { |f| f.start_date_formatted }).uniq
    else
      @available_flights = Flight.where(departure_airport_id: params[:departure_airport_id], arrival_airport_id: params[:arrival_airport_id])
      @available_flight_dates = (@available_flights.map{|f| f.start_date_formatted}).uniq
    end

  end



  private

  def flight_params
    params.require(:flight).permit(:departure_airport, :arrival_airport, :start_time, :end_time, :start_date_formatted)
  end
end
