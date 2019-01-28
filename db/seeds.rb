# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "WELCOME TO SEED\n\n"
puts "DESTROYING DB\n"
puts "Destroying users"
User.destroy_all
puts "Users destroyed\n"
puts "Destroying reservations"
Reservation.destroy_all
puts "Reservations destroyed\n"
puts "Destroying listings"
Listing.destroy_all
puts "Listings destroyed\n"
puts "Destroying cities"
City.destroy_all
puts "Cities destroyed\n"


puts "\n\n"
puts "SEEDING NEW DB\n"

puts "Seeding users"
20.times do 
	User.create(
    email: Faker::Internet.email,
    phone_number: "0607080910",
    description: Faker::Lorem.paragraph(25)
  )
end
puts "users seeded\n"


puts "Seeding cities"
10.times do |index|
  City.create(
    name: Faker::Address.city,
    zip_code: "33#{index.to_s}00"
  )
end
puts "cities seeded\n"


puts "Seeding listings"
50.times do 
  Listing.create(
    available_beds: rand(1..5),
    price: rand(10..100),
    description: Faker::Lorem.paragraph(15),
    has_wifi: Faker::Boolean.boolean,
    welcome_message: "Bienvenue dans ma super maison ! Pour y accéder il faut tourner la bobinette et la chevillette cherra",
    city: City.all.sample,
    admin: User.all.sample
  )
end
puts "Listings seeded\n"


puts "Seeding reservations"
Listing.all.each do |listing|
	10.times do |index|
		index = index - 5
		length = rand(5)
		start_date = Time.now + ((index)*5).day
		end_date = start_date + length.day 
		Reservation.create(
	    start_date: start_date,
	    end_date: end_date,
	    guest: User.all.sample,
	    listing: listing
		)
	end
end
puts "Reservations seeded\n"

puts "\nEND OF SEED"
puts "SEE YOU SOON 👋"