class Airline < ApplicationRecord
  has_many :flights
  has_many :manifests, through: :flights
  has_many :passengers, through: :manifests

  def over_18_passenger_list
    flights.joins(:passengers)
    .select("passengers.name")
    .distinct
    .where("age >= ?", 18)
  end

  # refactor into one metho
  def over_18_passenger_list_sort_by_most_flights
    flights.joins(:passengers)
    .select("passengers.*, count(manifests.passenger_id) as passenger_count")
    .group("passenger.id")
    .where("age >= ?", 18)
    .order('passenger_count DESC')
  end
end
