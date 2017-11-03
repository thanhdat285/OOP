class Api::V1::Customers::TicketsController < Api::V1::Customers::BaseController

  def book
  	@ticket = Ticket.find_by id: params[:id]
  	if @ticket.user_buy_id.present?
  		render json: {code: 0, message: "Vé này đã có người mua"}
  	else
  		@ticket.update_attributes(user_buy_id: @current_user.id)
  		render json: {code: 1, message: "Thành công"}
  	end
  end
end
