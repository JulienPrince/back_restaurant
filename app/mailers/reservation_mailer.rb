class ReservationMailer < ApplicationMailer
        
    def new_reservation_email
        @reservation = params[:reservation]
        email = params[:email]
        mail(to: email, subject: 'Nouvelle réservation')
    end
end
