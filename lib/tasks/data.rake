namespace :data do
  desc "TODO"
  task fake: :environment do
    puts "Create data"
    File.open("#{Rails.root}/docs/films/films.csv", "r") do |file|
      file.each_line.with_index do |line, index|
        next if index == 0
        line = line.gsub("\n", "")
        values = line.split("|")
        Film.create(
          name: values[0],
          image: "/images/films/" + values[1],
          kind: values[2],
          duration: values[3],
          release_date: values[4]
        )
      end
    end

    File.open("#{Rails.root}/docs/locations/locations.csv", "r") do |file|
      file.each_line.with_index do |line, index|
        next if index == 0
        line = line.gsub("\n", "")
        Location.create(name: line)
      end
    end

   u = User.create(name: "Seller", email: "one@gmail.com", password: "123456")

    Film.all.each do |film|
      Location.all.each do |location|
        r = rand()*2
        if r > 1
          FilmRoom.create(
            film_id: film.id,
            location_id: location.id,
            time_begin: Time.now,
            time_end: Time.now + 2.hours,
            user_sell_id: u.id
          )
        end
      end
    end
  end

end
