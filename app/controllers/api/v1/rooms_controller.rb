class Api::V1::RoomsController < Api::V1::BaseController

  def index
    rooms = Room.where(location_id: params[:location_id])
    render json: {code: 1, data: rooms}
  end
end
