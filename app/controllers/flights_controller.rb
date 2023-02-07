class FlightsController < ApplicationController
  def index
    @flights = Flight.all.order(start_time: :asc)
    flight_dates
    if params[:search]
      if flight_params.value?("")
        flight_params.each{|k,v|
          if v.nil?
            flash.now[:alert] = "Please add #{k}" 
            break
          end
        }
        render :index
      else
        @date_picked = Date.parse(params[:flight][:start_date])
        @flights = Flight.where(departure_airport_id: params[:flight][:departure_airport_id], arrival_airport_id: params[:flight][:arrival_airport_id], start_time: @date_picked.all_day).order(start_time: :asc)
        # flight_dates
        if @flights.nil?
          @flights = Flight.where(departure_airport_id: params[:flight][:departure_airport_id], arrival_airport_id: params[:flight][:arrival_airport_id]).order(start_time: :asc)
          # flight_dates
          flash.now[:alert] = "No flights on your selected date"

        end
        render :index
      end
    end
  end

  def flight_dates
    @flight_dates = @flights.map{|f| ("#{f.start_time.day.to_s.rjust(2,"0")}/#{f.start_time.month.to_s.rjust(2,"0")}/#{f.start_time.year}")}.uniq
  end

  private
  def flight_params
    params.require(:flight).permit(:departure_airport_id, :arrival_airport_id, :start_date, :passenger_count)
  end

end

# @date_picked = Date.parse(params[:start_date][5..-1].to_f, params[:start_date][3..4].to_f, params[:start_date][0..1].to_f)

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