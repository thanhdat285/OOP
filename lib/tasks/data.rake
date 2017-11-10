namespace :data do
  desc "TODO"
  task fake: :environment do
    puts "Create data"

    Film.bulk_insert do |worker|
      File.open("#{Rails.root}/docs/films/films.csv", "r") do |file|
        file.each_line.with_index do |line, index|
          next if index == 0
          line = line.gsub("\n", "")
          values = line.split("|")
          worker.add(
            name: values[0],
            image: "/images/films/" + values[1],
            kind: values[2],
            duration: values[3],
            release_date: values[4],
            content: values[5]
          )
        end
      end
    end

    Location.bulk_insert do |worker|
      File.open("#{Rails.root}/docs/locations/locations.csv", "r") do |file|
        file.each_line.with_index do |line, index|
          next if index == 0
          line = line.gsub("\n", "")
          worker.add(name: line)
        end
      end
    end

    seats = []
    chars = ["A", "B", "C", "D", "E", "F", "G", "H"]
    chars.each do |char|
      if char == "A" || char == "B"
        10.times do |time|
          seats.append(["#{char}", time+1, "VIP"])
        end
      else
        10.times do |time|
          seats.append(["#{char}", time+1, "NORMAL"])
        end
      end
    end

    Room.bulk_insert do |worker|
      Location.all.each do |location|
        r = (rand() * 3).to_i + 1
        r.times do |a|
          worker.add(location_id: location.id, name: "Phòng #{a+1}",
            seats: {
              values: seats
            })
        end
      end
    end

    
    Film.all.each do |film|
      Location.all.each do |location|
        u = User.create(name: "Seller", email: "#{location.id}x#{film.id}@gmail.com", password: "123456", role: User.roles[:seller],
          location_id: location.id)
        r = rand()*4
        if r >= 1
          schedule = Schedule.create(
            film_id: film.id,
            location_id: location.id,
            room_id: location.rooms.shuffle[0].id,
            time_begin: Time.now,
            time_end: Time.now + 2.hours,
            user_sell_id: u.id
          )
          
          Ticket.bulk_insert do |worker|
            schedule.room.seats["values"].each do |seat|
              worker.add(
                price: seat[2] == "VIP" ? 80000 : 40000,
                seat_row: seat[0],
                seat_col: seat[1],
                schedule_id: schedule.id
              )
            end
          end
          
        end
      end
    end
  end

end
