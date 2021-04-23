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
end
