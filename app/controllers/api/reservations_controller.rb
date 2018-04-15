class Api::ReservationsController < Api::BaseController
  def create
    reservation = Reservation.new(reservation_params_for_create)

    if reservation.save
      render status: :created, json: ReservationSerializer.new(reservation)
    else
      unprocessable!(reservation.errors)
    end
  end

  def update
    reservation = Reservation.find(params[:id])
    reservation.attributes = reservation_params_for_update
    changed_attributes = reservation.changed_attributes

    if reservation.save
      ReservationMailer.email_guest_with_updates(reservation, changed_attributes).deliver_now
      render status: :ok, json: ReservationSerializer.new(reservation)
    else
      unprocessable!(reservation.errors)
    end
  end

  private

  def reservation_params_for_create
    params.require(:reservation).permit(:guest_id, :table_id, :shift_id, :time, :guests_count)
  end

  def reservation_params_for_update
    params.require(:reservation).permit(:table_id, :shift_id, :time, :guests_count)
  end
end
