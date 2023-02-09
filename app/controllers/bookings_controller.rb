class BookingsController < ApplicationController
  def new
    @booking = Booking.new
    # @flight = Flight.find(params[:flight_id])
  end

  def create
    @booking = Booking.new(search_params)
    # @flight = Flight.find(params[:flight_id])
    # @booking = @flight.bookings.create(booking_params)
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

  private
  def search_params
    params.permit(:flight_id, :passenger_count)
  end
  
  def booking_params
    params.require(:booking).permit(:flight_id, :passenger_id, :passenger_attributes => [:name, :email])
  end
end