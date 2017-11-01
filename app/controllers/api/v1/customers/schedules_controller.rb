class Api::V1::Customers::SchedulesController < Api::V1::Customers::BaseController

  def index
  	@schedules = Schedule.select("schedules.*", "users.name").joins(:user_sell)
  		.where(location_id: params[:location_id])
  		.paginate(page: params[:page] || 1, per_page: 10)
  	render json: {code: 1, message: "Thành công", data: @schedules}
  end
end
