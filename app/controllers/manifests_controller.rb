class ManifestsController < ApplicationController

  def destroy
    flight = Flight.find(params[:flight_id])
    passenger = Passenger.find(params[:passenger_id])

    flight.passengers.delete(passenger)

    redirect_to flights_path
  end
end
