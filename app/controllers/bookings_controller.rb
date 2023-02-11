class BookingsController < ApplicationController
  def new
    @booking = Booking.new
    @flight = Flight.find(params[:flight_id])


    params[:passenger_count].to_i.times { @booking.passengers.build }

        # @passengers = Passenger.pluck(:email)
  end

  def create
    @booking = Booking.create(booking_params)

    if @booking.save
      flash[:success] = "Booking Successfully Created"
      rredirect_to booking_path(@booking), notice: 'Booking created!'
      # booking_url(@booking)
    else 
      # flash.now[:notice] = @booking.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @booking = Booking.find(params[:id])
  end

  # def index
  #   @booking = Booking.all
  # end



  private
  
  def booking_params
    params.require(:booking).permit(:id, :flight_id, passengers_attributes: [:id, :name, :email])
  end
end