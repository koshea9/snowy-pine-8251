class AirlinesController < ApplicationController
  def show
    @airline = Airline.find(params[:id])
    @over_18_passengers = @airline.over_18_passenger_list
  end
end
