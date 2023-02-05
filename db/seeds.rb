# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Destroy all airports to have a clean slate 
Airport.destroy_all
ActiveRecord::Base.connection.execute("DELETE from sqlite_sequence where name = 'airports'") 

# Add all airports passing an array into the create method
airports = [
  ["LHR", "London Heathrow"],
  ["LGW", "London Gatwick"],
  ["SFO", "San Francisco"],
  ["AGP", "Malaga"],
  ["AMS", "Amsterdam"],
  ["HKG", "Hong Kong"],
  ["CDG", "Paris"],
  ["DEL", "Delhi"],
  ["KRK", "Krakow"],
  ["MIA", "Miami"],
  ["HAN", "Hanoi"],
  ["AKL", "Aukland"]
]


airports.each do |airport|
  Airport.create!(code: airport[0], name: airport[1])
end

p "Created #{Airport.count} airports"

# # seed database with flights

# destroy existing to reset

# Flight.destroy_all
# ActiveRecord::Base.connection.execute("DELETE from sqlite_sequence where name = 'flights'")

# # add flights

# 4.times {
#   a = Airport.order("RANDOM()")
#   t = Time.now + rand(10000000)
#   et = t + rand(50000)
#   f = Flight.new
#   f.departure_airport_id = a.first
#   f.arrival_airport_id = a.last
#   f.start_time = t
#   f.end_time = et
#   f.save
# }
# p "Created #{Flight.count} flights"