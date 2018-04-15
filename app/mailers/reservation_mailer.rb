class ReservationMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def email_guest(reservation)
    @reservation = reservation
    @guest = @reservation.guest
    @restaurant = @reservation.shift.restaurant

    mail to: @guest.email, subject: "Reservation confirmed for #{@restaurant.name}."
  end

  def email_restaurant(reservation)
    @reservation = reservation
    @guest = @reservation.guest
    @restaurant = @reservation.shift.restaurant

    mail to: @restaurant.email, subject: "Reservation #{@reservation.id} for #{@guest.name}."
  end

  def email_guest_with_updates(reservation, changed_attributes)
    @reservation = reservation
    @guest = @reservation.guest
    @restaurant = @reservation.shift.restaurant
    @changed_attributes = changed_attributes

    mail to: @guest.email, subject: "Reservation updated for #{@restaurant.name}."
  end
end
