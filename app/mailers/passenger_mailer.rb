class PassengerMailer < ApplicationMailer
    default from: 'notifications@example.com'
    default to: -> {@booking.passengers.pluck(:email)}
    # def welcome_email
    #   @user = params[:user]
    #   @url  = 'http://example.com/login'
    #   mail(to: @user.email, subject: 'Welcome to My Awesome Site')
    # end  

    def booking_confirmation_email
      @passenger = params[:passenger]
      @url = 'http://example.com/login'
      mail(to: @passenger.email, subject: 'Booking Confirmed!')
    end
end
