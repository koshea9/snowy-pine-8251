require 'rails_helper'

RSpec.describe "flights index page", type: :feature do
  before :each do
    #airlines(have many flights)
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
  end

  it 'shows a list of all flights by number and name of airline' do
    visit flights_path

    expect(page).to have_content(@flight_1.number)
    expect(page).to have_content(@flight_2.number)
    expect(page).to have_content(@flight_3.number)
    expect(page).to have_content(@airline_1.name)
    expect(page).to have_content(@airline_2.name)
  end

  it 'lists the names of all passengers under each flight' do
    visit flights_path

    within "#flight-#{@flight_1.id}" do
      expect(page).to have_content(@passenger_4.name)
      expect(page).to have_content(@passenger_2.name)
      expect(page).to have_content(@passenger_3.name)
    end
    within "#flight-#{@flight_3.id}" do
      expect(page).to have_content(@passenger_1.name)
    end
  end

  it 'allows user to remove passenger from flight' do
    visit flights_path

    within "#flight-#{@flight_1.id}" do
      within "#passenger-#{@passenger_4.id}" do
      expect(page).to have_content(@passenger_4.name)

      click_button "Remove Passenger"

      expect(current_path).to eq(flights_path)
      end
      
      expect(page).to_not have_content(@passenger_4.name)
    end
  end
end
