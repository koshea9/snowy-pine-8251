require 'rails_helper'

RSpec.describe "airline's show page", type: :feature do
  before :each do
    #airlines(have many flights)
    @airline_1 = Airline.create!(name: '1 airline')

    #flights(belong to airline)
    @flight_1 = @airline_1.flights.create!(number: 1, date: '08/03/20', departure_city: "Denver", arrival_city: "Seattle" )
    @flight_2 = @airline_1.flights.create!(number: 2, date: '08/03/20', departure_city: "Denver", arrival_city: "Seattle" )
    @flight_3 = @airline_1.flights.create!(number: 3, date: '08/03/20', departure_city: "Denver", arrival_city: "Seattle" )

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
    @manifest_5 = Manifest.create!(passenger: @passenger_1, flight: @flight_2)
    @manifest_6 = Manifest.create!(passenger: @passenger_4, flight: @flight_3)
    @manifest_6 = Manifest.create!(passenger: @passenger_4, flight: @flight_2)
  end

  it "shows a unique list of adult passengers (>=18) that have flights on airline" do
    visit airline_path(@airline_1)

    expect(page).to have_content(@passenger_1.name)
    expect(page).to have_content(@passenger_2.name)
    expect(page).to have_content(@passenger_4.name)
    expect(page).to_not have_content(@passenger_3.name)
  end
  # extenion WIP
  xit "shows adult passengers sorted by number of flights taken from most to least" do
    visit airline_path(@airline_1)

    expect(@passenger_4.name).to appear_before(@passenger_2.name)
    expect(@passenger_1.name).to appear_before(@passenger_2.name)

  end
end
