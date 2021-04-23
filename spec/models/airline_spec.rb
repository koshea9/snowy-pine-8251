require 'rails_helper'

RSpec.describe Airline, type: :model do
  it {should have_many :flights}
  it {should have_many(:manifests).through(:flights)}
  it {should have_many(:passengers).through(:manifests)}

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

  describe 'instance methods' do
    describe '#over_18_passenger_list' do
      it "returns a unique list of passengers for an airlines flight that are over 18" do
        actual = @airline_1.over_18_passenger_list.map do |passenger|
          passenger.name
        end

        expected = [@passenger_1, @passenger_2, @passenger_4].map do |passenger|
          passenger.name
        end

        expect(actual).to eq(expected.sort)
      end
    end
  end

  # extension WIP refactor into one method
  xdescribe '#over_18_passenger_list_sort_by_most_flights' do
    it "returns a unique list of passengers for an airlines flight that are over 18 and orders by most flights" do
      actual = @airline_1.over_18_passenger_list_sort_by_most_flights.map do |passenger|
        passenger.name
      end

      expected = [@passenger_4, @passenger_1, @passenger_2].map do |passenger|
        passenger.name
      end

      expect(actual).to eq(expected)
    end
  end
end
