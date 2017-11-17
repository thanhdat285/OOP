json.code 1
json.message "Thành công"
json.data @tickets.each do |ticket|
	json.merge! ticket.attributes
	json.time_user_book ticket.updated_at.strftime("%d/%m/%Y %H:%M") rescue nil
	json.time_begin ticket.time_begin.strftime("%d/%m/%Y %H:%M") rescue nil
	json.time_end ticket.time_end.strftime("%d/%m/%Y %H:%M") rescue nil
end
