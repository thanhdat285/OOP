class Api::V1::Customers::TicketsController < Api::V1::Customers::BaseController

  def create
    room = Room.find_by(id: params[:room_id])
    schedule = Schedule.create(schedule_params.merge(location_id: room.location_id,
      user_sell_id: @current_user.id))
    Ticket.bulk_insert do |worker|
      room.seats["values"].each do |seat|
        worker.add(
          schedule_id: schedule.id,
          seat_row: seat[0],
          seat_col: seat[1],
          price: get_price_on_seat_type(seat)
        )
      end
    end

    render json: {code: 1, message: "Thành công"}
  end

  private
  def schedule_params
    params.permit(:film_id, :room_id, :time_begin, :time_end)
  end

  def get_price_on_seat_type seat
    if seat[2] == "VIP"
      return params[:vip]
    elsif seat[2] == "NORMAL"
      return params[:normal]
    end
  end
end
