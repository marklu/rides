class ArrangementsController < ApplicationController
  before_filter :get_trip

  # GET /arrangements
  # GET /arrangements.xml
  def index
    @arrangements = @trip.arrangements

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @arrangements }
    end
  end

  # GET /arrangements/1
  # GET /arrangements/1.xml
  def show
    @arrangement = @trip.arrangements.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @arrangement }
    end
  end

  private

  def get_trip
    @trip = Trip.find(params[:trip_id])
  end
end
