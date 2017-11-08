json.code 1
json.message "Thành công"
json.data @films.each do |film|
  json.merge! film.attributes
  json.release_date film.release_date.strftime("%d/%m/%Y") rescue nil
end
