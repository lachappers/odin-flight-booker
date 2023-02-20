# Preview all emails at http://localhost:3000/rails/mailers/passenger_mailer
class PassengerMailerPreview < ActionMailer::Preview
  def booking_confirmation_email
    PassengerMailer.with(passenger: Passenger.first).booking_confirmation_email
  end
end
