json.code 1
json.message "Thành công"
json.data @schedules.each do |schedule|
  json.merge! schedule.attributes
  json.time_begin schedule.time_begin.strftime("%d/%m/%Y %H:%M") rescue nil
  json.time_end schedule.time_end.strftime("%d/%m/%Y %H:%M") rescue nil
end
