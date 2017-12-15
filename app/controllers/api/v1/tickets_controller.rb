class Api::V1::TicketsController < Api::V1::BaseController
  before_action :check_seller, only: [:history_users_book]

  def book
  	params[:ticket_ids] = JSON.parse(params[:ticket_ids]) if params[:ticket_ids].present? && params[:ticket_ids].is_a?(String)
  	if params[:ticket_id].present?
	  	@ticket = Ticket.where id: params[:ticket_id]
  		if @current_user.book_tickets(@ticket)
  			render json: {code: 1, message: "Thành công", data: {balance: @current_user.balance}}
  		else
			render json: {code: 0, message: "Đặt vé thất bại"}
  		end
	elsif params[:ticket_ids].present?
		@tickets = Ticket.where(id: params[:ticket_ids])
		if @current_user.book_tickets(@tickets)
			render json: {code: 1, message: "Thành công", data: {balance: @current_user.balance}}
		else
			render json: {code: 0, message: "Đặt vé thất bại."}
		end
	end
  end

  def history_book
    @tickets = @current_user.history_book_tickets
  end

  def history_users_book
  	if params[:location_id].present?
  	  @tickets = Ticket.select("tickets.*", "films.name as film_name", "films.id as film_id", 
        "locations.id as location_id", "locations.name as location_name", "schedules.time_begin", 
        "schedules.time_end", "films.image as film_image", "users.name as user_buy_name")
  	  	.joins(schedule: [:location, :film]).joins(:user_buy)
  	    .where("schedules.user_sell_id = #{@current_user.id} AND schedules.location_id = #{params[:location_id].to_i}")
  	    .order("tickets.updated_at DESC")
  	  @total_tickets = Ticket.joins(:schedule).where(schedules: {user_sell_id: @current_user.id, 
  	  	location_id: params[:location_id].to_i}).count
  	elsif params[:film_id].present?
  		@tickets = Ticket.select("tickets.*", "films.name as film_name", "films.id as film_id", 
          "locations.id as location_id", "locations.name as location_name", "schedules.time_begin", 
          "schedules.time_end", "films.image as film_image", "users.name as user_buy_name")
  		  .joins(schedule: [:location, :film]).joins(:user_buy)
  	      .where("schedules.user_sell_id = #{@current_user.id} AND schedules.film_id = #{params[:film_id].to_i}")
  	      .order("tickets.updated_at DESC")
	    @total_tickets = Ticket.joins(:schedule).where(schedules: {user_sell_id: @current_user.id, 
  	  	  film_id: params[:film_id].to_i}).count
  	else
	  @tickets = Ticket.select("tickets.*", "films.name as film_name", "films.id as film_id", 
        "locations.id as location_id", "locations.name as location_name", "schedules.time_begin", 
        "schedules.time_end", "films.image as film_image", "users.name as user_buy_name")
	    .joins(:user_buy).joins(schedule: [:location, :film]).where("schedules.user_sell_id = #{@current_user.id}")
	    .order("tickets.updated_at DESC")
	  @total_tickets = Ticket.joins(:schedule).where(schedules: {user_sell_id: @current_user.id}).count
	end
  end
end
