# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
@airline_1 = Airline.create!(name: '1 airline')
@airline_2 = Airline.create!(name: '2 airline')

#flights(belong to airline)
@flight_1 = @airline_1.flights.create!(number: 1, date: '08/03/20', departure_city: "Denver", arrival_city: "Seattle" )
@flight_2 = @airline_1.flights.create!(number: 2, date: '08/03/20', departure_city: "Denver", arrival_city: "Seattle" )
@flight_3 = @airline_2.flights.create!(number: 3, date: '08/03/20', departure_city: "Denver", arrival_city: "Seattle" )

#passengers(associated through join table)
@passenger_1 = Passenger.create!(name: 'bob', age: 20)
@passenger_2 = Passenger.create!(name: 'amy', age: 50)
@passenger_3 = Passenger.create!(name: 'craig', age: 10)
@passenger_4 = Passenger.create!(name: 'sam', age: 30)

#manifest(join table)
@manifest_1 = Manifest.create!(passenger: @passenger_4, flight: @flight_1)
@manifest_2 = Manifest.create!(passenger: @passenger_2, flight: @flight_1)
@manifest_3 = Manifest.create!(passenger: @passenger_3, flight: @flight_1)
@manifest_4 = Manifest.create!(passenger: @passenger_1, flight: @flight_3)
