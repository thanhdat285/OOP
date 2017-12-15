class Api::V1::SchedulesController < Api::V1::BaseController
  before_action :check_seller, only: [:create]

  def index
    if params[:location_id].present?
    	@schedules = Schedule.select("schedules.*", "users.name as user_sell_name", "films.name as film_name", 
    		"films.image as film_image", "films.kind as film_kind").joins(:user_sell)
    		.joins(:film).where(location_id: params[:location_id])
    		.paginate(page: params[:page] || 1, per_page: 10)
    elsif params[:film_id].present?
      @schedules = Schedule.select("schedules.*", "users.name as user_sell_name", "films.name as film_name", 
        "films.image as film_image", "films.kind as film_kind", "locations.name").joins(:user_sell).joins(:film)
        .joins(:location).where(film_id: params[:film_id])
        .paginate(page: params[:page] || 1, per_page: 10)
    end
  end

  def show
  	@schedule = Schedule.select("*").joins(:room).joins(:film).find_by id: params[:id]
    @seats = JSON.parse(@schedule.seats)["values"]
    @tickets = @schedule.tickets
    for i in 0..(@seats.length-1) do 
      ticket = get_ticket @seats[i][0], @seats[i][1]
      next unless ticket.present?
      if ticket.user_buy_id.present?
        @seats[i] += [true, ticket.price, ticket.id]
      else
        @seats[i] += [false, ticket.price, ticket.id]
      end
    end
  end

  def create
    # require schedule_params and price_VIP, price_NORMAL 
    if @current_user.create_schedule(params)
      render json: {code: 1, message: "Tạo mới thành công"}
    else
      render json: {code: 0, message: "Tạo mới thất bại"}
    end
  end

  private
  def get_ticket row, col
    @tickets.each do |ticket|
      return ticket if ticket.seat_row == row && ticket.seat_col == col
    end
    return nil
  end

  def schedule_params
    params.permit(:film_id, :room_id, :time_begin, :time_end)
  end
end
