class FlightsController < ApplicationController
  def new
    @flight = Flight.new
  end

  def index
  # new flight object required to add params to a flight object
  @flight = Flight.new
  @flights = Flight.all.order(start_time: :asc)
  # params[:flight].compact_blank!
  if params[:flight]
    params[:flight].compact_blank!
    flight_search

  # else

  #   @flights = Flight.all.limit(20).order(start_time: :asc)
  end 
    @airport_options = Flight.airport_options
    get_flight_dates
  end

  def get_flight_dates
    @flight_dates = @flights.map{|f|  Date.parse(f.start_time.to_s)}.uniq
  end

  def flight_search
    
    # @flight_params = flight_params
    if params[:flight].empty?
      flash.now[:alert] = "No search criteria set!"
      # flash.now[:notice] = params[:flight].errors.full_messages.to_sentence
      # render :index, status: :unprocessable_entity

    elsif params[:flight][:start_date]
      @search_params = search_params
      search_results
    else
      # works
      @flights = @flights.where(flight_params).order(start_time: :asc)
    end
  end

  def search_results
    @date_picked = Date.parse(@search_params[:start_date])
    @flights = @flights.where(start_time: @date_picked.all_day).order(start_time: :asc)
    if @search_params[:departure_airport_id] || @search_params[:arrival_airport_id]
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


end

  # def booking_params
  #   # remove this when debugging done?
  #   # params.permit(:passenger_count, :flight_id)
  # end

      #   # .map{|f| ("#{f.start_time.day.to_s.rjust(2,"0")}/#{f.start_time.month.to_s.rjust(2,"0")}/#{f.start_time.year}")}.uniq