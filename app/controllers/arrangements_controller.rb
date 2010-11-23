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

  # POST /trip/:id/arrangements/generate
  def generate
    @trip.generate_arrangements
    redirect_to @trip
  end

  private

  def get_trip
    @trip = Trip.find(params[:trip_id])
  end
end
