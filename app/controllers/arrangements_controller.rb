class ArrangementsController < ApplicationController
  before_filter :authenticate_person!
  before_filter :get_trip

  # GET /arrangements
  def index
    @arrangements = @trip.arrangements
  end

  # GET /arrangements/1
  def show
    @arrangement = @trip.arrangements.find(params[:id])
  end

  private

  def get_trip
    @trip = Trip.find(params[:trip_id])
  end
end
