class ArrangementsController < ApplicationController
  before_filter :authenticate_person!
  load_resource :trip
  load_resource :through => :trip, :except => [:index]
  before_filter :check_abilities

  # GET /arrangements
  def index
    @arrangements = @trip.arrangements
  end

  # POST /trip/:id/arrangements/generate
  def generate
    if @trip.vehicles.map {|v| v.capacity}.sum >= @trip.participants.count
      arrangements = @trip.vehicles.map do |vehicle|
        Arrangement.new(
          :origin => vehicle.owner.location,
          :destination => @trip.location,
          :trip => @trip,
          :vehicle => vehicle
        )
      end
      unassigned_passengers = @trip.participants - @trip.drivers
      @trip.arrangements = ArrangementsGenerator.generate_arrangements(arrangements, unassigned_passengers)
      @trip.save!
      redirect_to(trip_arrangements_path(@trip), :notice => 'Arrangements have been generated')
    else
      redirect_to(trip_arrangements_path(@trip), :alert => 'There are not enough cars to generate arrangements')
    end
  end

  private

  def check_abilities
    new_arrangement = @trip.arrangements.build
    authorize!(params[:action].to_sym, @arrangement || new_arrangement)
    @trip.arrangements.delete(new_arrangement)
  end
end
