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

  end

end
