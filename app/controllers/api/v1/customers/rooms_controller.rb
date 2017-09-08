class Api::V1::Customers::RoomsController < Api::V1::Customers::BaseController

  def index
    rooms = Room.where(location_id: params[:location_id])
    render json: {code: 1, data: rooms}
  end
end
