class Api::RestaurantsController < Api::BaseController

  def reservations
    restaurant = Restaurant.find(params[:id])
    page = params[:page].present? ? [params[:page].to_i, 1].max : 1

    reservations = restaurant.reservations.paginate(page: page, per_page: pagination_size)
    render status: 200, json: ReservationSerializer.new(reservations,
                                                        meta: { total: reservations.count, per_page: pagination_size },
                                                        include: [:table, :guest])
  end

  private

  def pagination_size
    100
  end
end
