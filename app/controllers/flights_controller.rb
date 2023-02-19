class FlightsController < ApplicationController

  def index
    @flights = Flight.all.order(start_time: :asc)
    if params[:flight]
      params[:flight].compact_blank!
      flight_search
      if params[:passenger_count].empty?
        flash.now[:alert] = 'Select number of passengers before you can book your flight'
      end
    end
    @airport_options = Flight.airport_options
    set_search_variables
    get_flight_dates
    # render :index
  end

  def get_flight_dates
    @flight_dates = @flights.map { |f| Date.parse(f.start_time.to_s)}.uniq
  end

  def flight_search
    if !params[:start_date].empty?
      # fliter by date
      date_results
    elsif params[:flight].empty?
      # don't filter flights
      flash.now[:alert] = "No airports selected!"
      # render :index, status: :unprocessable_entity
    else
      # filter by flight params
      @flights = @flights.where(flight_params).order(start_time: :asc)
    end
  end

  def date_results
    @date_picked = Date.parse(params[:start_date])
    if params[:flight].empty?
      @flights = @flights.where(start_time: @date_picked.all_day).order(start_time: :asc)
    else
      @flights = @flights.where(flight_params, start_time: @date_picked.all_day).order(start_time: :asc)
    end
  end


  private
  def flight_params
    params.require(:flight).permit(:departure_airport_id, :arrival_airport_id)

  end
  def search_params
    params.permit(:start_date, :passenger_count, :flight_id)
    # params.require(:flight).permit(:departure_airport_id, :arrival_airport_id, :start_date, :passenger_count, :flight_id, :commit)
  end
  def set_search_variables
    @passenger_count = params[:passenger_count]
    @start_date = params[:start_date]
    if params[:flight]
      @departure_airport_id = params[:flight][:departure_airport_id]
      @arrival_airport_id = params[:flight][:arrival_airport_id]
    end
  end

end

  # def booking_params
  #   # remove this when debugging done?
  #   # params.permit(:passenger_count, :flight_id)
  # end

      #   # .map{|f| ("#{f.start_time.day.to_s.rjust(2,"0")}/#{f.start_time.month.to_s.rjust(2,"0")}/#{f.start_time.year}")}.uniq