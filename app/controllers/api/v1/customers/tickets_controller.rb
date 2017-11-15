class Api::V1::Customers::TicketsController < Api::V1::Customers::BaseController

  def book
  	if params[:ticket_id].present?
	  	@ticket = Ticket.find_by id: params[:ticket_id]
	  	if @ticket.user_buy_id.present?
	  		return render json: {code: 0, message: "Vé này đã có người mua"}
	  	else
	  		if @current_user.balance < @ticket.price
	  			return render json: {code: 0, message: "Tài khoản của bạn không còn đủ tiền"}
	  		end
	  		@ticket.update_attributes(user_buy_id: @current_user.id)
	  		@current_user.pay(@ticket.price)
	  		render json: {code: 1, message: "Thành công", data: {balance: @current_user.balance}}
	  	end
	elsif params[:ticket_ids].present? && params[:ticket_ids].is_a?(Array)
		@tickets = Ticket.where(id: params[:ticket_ids])
		user_bought = false
		@tickets.each do |ticket|
			if ticket.user_buy_id.present?
				user_bought = true 
				break
			end
		end

		return render json: {code: 0, message: "Tồn tại một vé đã có người mua"} if user_bought

		_total_price = total_price(@tickets)
		if @current_user.balance < _total_price
			return render json: {code: 0, message: "Tài khoản của bạn không còn đủ tiền"}
		end

		@tickets.update_all(user_buy_id: @current_user.id)
		@current_user.pay(_total_price)
		render json: {code: 1, message: "Thành công", data: {balance: @current_user.balance}}
	end
  end

  private
  def total_price tickets 
  	price = 0
  	tickets.each do |ticket|
  		price += ticket.price 
  	end
  	return price
  end
end
