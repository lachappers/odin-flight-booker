class BookingsController < ApplicationController
  def new
    @booking = Booking.new
    @booking.flight = Flight.find(params[:flight_id])
    params[:passenger_count].to_i.times { @booking.passengers.build }
  end

  def create

    @booking = Booking.new(booking_params)
    @booking.passenger_count = @booking.passengers.count
    if @booking.save
      # booking.passenger_count = 
      flash[:success] = "Booking Successfully Created"
      redirect_to @booking
      # , notice: 'Booking created!'
      # booking_url(@booking)
    else 
      flash[:alert] = "An error occured"
      flash.now[:notice] = @booking.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @booking = Booking.find(params[:id])
    @booking.flight = Flight.find(@booking[:flight_id])
  end

  def index
    @bookings = Booking.all
  end



  private
  
  def booking_params
    params.require(:booking).permit(:id, :flight_id, :passenger_count, passengers_attributes: [:id, :name, :email, :_destroy])
  end
  def search_params
    params.permit(:passenger_count, :flight_id, :commit, :book)
  end
end