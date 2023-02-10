class BookingsController < ApplicationController
  def new
    @booking = Booking.new
    @flight = Flight.find(params[:flight_id])
    params[:passenger_count].to_i.times { @booking.passengers.build }
  end

  def create
    # @passengers = @booking.passengers.create(passenger_params)
    # @booking = Booking.new(search_params)
    # @flight = Flight.find(params[:flight_id])
    # @booking = @flight.bookings.create(booking_params)
    p params
    if @booking.save
      flash[:success] = "Booking Successfully Created"
      # redirect_to booking_url(@booking)
    else 
      flash.now[:notice] = @booking.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @booking = Booking.find(params[:id])
  end

  def index
    @booking = Booking.all
  end

  def passengers
    # @passengers = 
  end

  private
  def search_params
    params.require(:booking).permit(:flight_id, :passenger_count, :commit)
  end
  
  def booking_params
    params.require(:booking).permit(:flight_id, :passengers_attributes => [:id, :name, :email])
  end
end