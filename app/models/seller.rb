class Seller < User
	scope :schedules, -> {
		Schedule.where(user_sell_id: self.id)
	}

	def create_schedule params
		room = Room.find_by(id: params[:room_id])
		schedule = Schedule.new({
			film_id: params[:film_id],
			room_id: params[:room_id],
			location_id: room.location_id,
			time_begin: params[:time_begin],
			time_end: params[:time_end],
			user_sell_id: self.id
		})
	    if schedule.save 
	      Ticket.bulk_insert do |worker|
	        room.seats["values"].each do |seat|
	          worker.add(
	            price: params["price_#{seat[2]}".to_sym],
	            seat_row: seat[0],
	            seat_col: seat[1],
	            schedule_id: schedule.id
	          )
	        end
	      end
	      return true
	    end
	    return false
	end
end
