class Airline < ApplicationRecord
  has_many :flights
  has_many :manifests, through: :flights
  has_many :passengers, through: :manifests
end
