class PeopleController < ApplicationController
  before_filter :authenticate_person!, :only => [:dashboard]

  # GET /
  def index
    redirect_to person_root_url if person_signed_in?
  end

  # GET /dashboard
  def dashboard
    @upcoming_trips = current_person.upcoming_trips
    logger.info(current_person.id)
    @pending_trips = current_person.pending_trips
  end
end
