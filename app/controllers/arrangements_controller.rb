class ArrangementsController < ApplicationController
  before_filter :authenticate_person!
  load_resource :trip
  load_resource :through => :trip, :except => [:index]
  before_filter :check_abilities

  # GET /arrangements
  def index
    @arrangements = @trip.arrangements
  end

  # GET /arrangements/1
  def show
  end

  # POST /trip/:id/arrangements/generate
  def generate
    @trip.generate_arrangements
    redirect_to @trip
  end

  private

  def check_abilities
    new_arrangement = @trip.arrangements.build
    authorize!(params[:action].to_sym, @arrangement || new_arrangement)
    @trip.arrangements.delete(new_arrangement)
  end
end
