class Api::V1::Customers::SchedulesController < Api::V1::Customers::BaseController
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
    # require schdule_params and price_VIP, price_NORMAL 
    @room = Room.find_by(id: params[:room_id])
    @schedule = Schedule.new(schedule_params.merge(location_id: @room.location_id,
      user_sell_id: @current_user.id))
    if @schedule.save 
      Ticket.bulk_insert do |worker|
        @room.seats["values"].each do |seat|
          worker.add(
            price: params["price_#{seat[2]}".to_sym],
            seat_row: seat[0],
            seat_col: seat[1],
            schedule_id: @schedule.id
          )
        end
      end
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
