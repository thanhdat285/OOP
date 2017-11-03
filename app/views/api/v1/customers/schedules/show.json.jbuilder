json.code 1
json.message "Thành công"
json.data do 
	json.merge! @schedule.attributes
	json.seats @seats
	json.time_begin @schedule.time_begin.strftime("%d/%m/%Y %H:%M")
	json.time_end @schedule.time_end.strftime("%d/%m/%Y %H:%M")
end
