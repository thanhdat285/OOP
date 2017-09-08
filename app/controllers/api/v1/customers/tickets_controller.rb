class Api::V1::Customers::RoomsController < Api::V1::Customers::BaseController

  def index
    tickets = Ticket.where(room_id: params[:room_id])
    render json: {code: 1, data: tickets}
  end
end
