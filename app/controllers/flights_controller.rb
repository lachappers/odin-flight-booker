class FlightsController < ApplicationController

  def index
    @flights = Flight.all.order(start_time: :asc)
    @airport_options = Flight.airport_options
    @flight_dates = flight_dates
    @search_params = search_params
    if params[:commit] == "Search"
      flight_search
    end 
  end

  def flight_dates
    @flights.map{|f| ("#{f.start_time.day.to_s.rjust(2,"0")}/#{f.start_time.month.to_s.rjust(2,"0")}/#{f.start_time.year}")}.uniq
  end

  def flight_search
    @search_params.delete_if{ |k , v| v.blank?}
    if @search_params.empty?
      flash.now[:alert] = "No search criteria set!"
            # flash.now[:notice] = params[:flight].errors.full_messages.to_sentence
      render :index, status: :unprocessable_entity
    else
      @flight_params = flight_params.delete_if{|k,v| v.blank?}
      search_results
      @booking_params = booking_params
    end
  end

  def search_results
    if @search_params[:start_date]
      @date_picked = Date.parse(@search_params[:start_date])
      if @flight_params.empty?
        @flights = @flights.where(start_time: @date_picked.all_day).order(start_time: :asc)
      else
       @flights = @flights.where(@flight_params, start_time: @date_picked.all_day).order(start_time: :asc)
      end
    else
      @flights = @flights.where(@flight_params).order(start_time: :asc)
    end
  end


  private
  def flight_params
    # params.require(:flight).permit(:departure_airport_id, :arrival_airport_id)
    params.permit(:departure_airport_id, :arrival_airport_id)
  end
  def search_params
    params.permit(:departure_airport_id, :arrival_airport_id, :start_date, :passenger_count, :flight_id, :commit)
  end
  def booking_params
    # remove this when debugging done?
    params.permit(:passenger_count, :flight_id)
  end

end


  # def index
  #   @airport_options = Airport.pluck(:name, :id)
  #   @flights = Flight.all.order(start_time: :asc)

  #   if params[:departure_airport] == params[:arrival_airport]
  #     flash.now[:alert] = "Please select two different airports!"
  #     # render :index
  #   elsif params[:departure_airport] && params[:arrival_airport]
  #     @flights = Flight.where(departure_airport_id: params[:departure_airport_id],arrival_airport_id: params[:arrival_airport_id])

  #   elsif params[:departure_airport]
  #     @flights = Flight.where(departure_airport_id: params[:departure_airport_id])

  #   else
  #     @flights = Flight.all
  #   end
  #   render :index
  # end
    # def find_available_flights
  #   if params[:departure_airport] == params[:arrival_airport]
  #     flash.now[:alert] = "Please select two different airports!"
  #     render :index
  #   else
  #     @available_flight_dates = available_flight_dates
  #     return @available_flights = Flight.where(departure_airport_id: params[:departure_airport], arrival_airport_id: params[:arrival_airport])

  #   end
  # end
  # (:start_time).to_s[0..9]

  # def index
  #   @airport_options = Airport.pluck(:name, :id)
  #   # @all_flights = Flight.all.order(start_time: :asc)
  #   if params[:search]
  #     # @flights = Flight.where(:search)
  #     @flights = Flight.where(departure_airport_id: params[:departure_airport_id], arrival_airport_id: params[:arrival_airport_id], "#{@start_date_formatted}" => params[:start_date]).order(start_time: :asc)
  #       if @flights.count <1
  #         @flights = Flight.where(departure_airport_id: params[:departure_airport_id], arrival_airport_id: params[:arrival_airport_id]).order(start_time: :asc)
  #         flash.now[:alert] = "No flights on your selected date"
  #       end
  #     @flight_dates = @flights.map{|f| f.start_date_formatted}.uniq
  #     render :index
  #   else
  #     @flights = Flight.all.order(start_time: :asc)

  #   end

  #   @flight_dates = @flights.map{|f| Date.civil("#{f.start_time.day}", "#{f.start_time.month}","#{f.start_time.year}")}.uniq
  #   # render :index
  # end

  # def search 
  #   @flights = Flight.where(flight_params).order(start_time: :asc)

  # end

  # @flights = Flight.all.order(start_time: :asc)
  # flight_dates
  # # p @flights
  # if params[:search]
  #   # flight_params
  #   flight_params.each{|k,v|
  #     if v.empty?
  #       flash.now[:alert] = "Please add #{k}" 
  #       render :index, status: :unprocessable_entity
  #       # break
  #     end
  #   }
  #   @date_picked = Date.parse(params[:flight][:start_date])
  #   @flights = Flight.where(departure_airport_id: params[:flight][:departure_airport_id], arrival_airport_id: params[:flight][:arrival_airport_id], start_time: @date_picked.all_day).order(start_time: :asc)
  #   if @flights.nil?
  #     @flights = Flight.where(departure_airport_id: params[:flight][:departure_airport_id], arrival_airport_id: params[:flight][:arrival_airport_id]).order(start_time: :asc)
  #     # flight_dates
  #     flash.now[:alert] = "No flights on your selected date"
  #   end
  #   # redirect_to :index
  # end

  # def index
  #   @search_params = {}
  #   @flights = Flight.all.order(start_time: :asc)
  #   flight_dates
  #   if params[:search]
  #     if params.valid?
  #       @date_picked = Date.parse(params[:flight][:start_date])
  #       @flights = Flight.where(departure_airport_id: params[:flight][:departure_airport_id], arrival_airport_id: params[:flight][:arrival_airport_id], start_time: @date_picked.all_day).order(start_time: :asc)
  #       if @flights.nil?
  #         @flights = Flight.where(departure_airport_id: params[:flight][:departure_airport_id], arrival_airport_id: params[:flight][:arrival_airport_id]).order(start_time: :asc)
  #         # flight_dates
  #         flash.now[:alert] = "No flights on your selected date"
  #       end
  #     else
  #       @flights = Flight.all.order(start_time: :asc)
  #       flash.now[:notice] = @flights.errors.full_messages.to_sentence
  #       render :new, status: :unprocessable_entity
  #     end
  #   else
  #     render :index
  #   end
  # end

    # def new
  #   @flight = Flight.new
  #   # airports in app controller
  #   @flight_dates = flight_dates
  # end

  # def create
  #   @flight = Flight.new(flight_params)
  #   if @flight.save
  #     # redirect_to @flight
  #     render :index
  #   else
  #     render :new, status: :unprocessable_entity
  #   end
  # end