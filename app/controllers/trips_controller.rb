class TripsController < ApplicationController
  before_filter :authenticate_person!

  # GET /trips
  def index
    if !params[:month].nil? && !params[:year].nil?
      @trips = current_person.trips.select do |trip|
        trip.time.month == params[:month].to_i && trip.time.year == params[:year].to_i
      end
    else
      @trips = current_person.trips
    end

    @months_with_trips = current_person.trips.map do |trip|
      trip.time
    end.sort.reverse.map do |time|
      {:month => time.month, :year => time.year}
    end.uniq
  end

  # GET /trips/1/participants
  def participants
    @trip = Trip.find(params[:id])
    @participants = @trip.participants.sort_by {|participant| participant.name}
  end

  # DELETE /trips/1/participants
  def leave
    @trip = Trip.find(params[:id])
    @trip.participants.delete(current_person)

    redirect_to(person_root_url, :notice => "You are no longer participating in #{@trip.name}")
  end

  # GET /trips/1
  def show
    @trip = Trip.find(params[:id])
  end

  # GET /trips/new
  def new
    @trip = current_person.organized_trips.build
  end

  # GET /trips/1/edit
  def edit
    @trip = current_person.organized_trips.find(params[:id])
  end

  # POST /trips
  def create
    @trip = current_person.organized_trips.build(params[:trip])
    @trip.participants << current_person

    if @trip.save
      redirect_to(@trip, :notice => 'Trip was successfully created.')
    else
      render :action => "new"
    end
  end

  # PUT /trips/1
  def update
    @trip = Trip.find(params[:id])

    if @trip.update_attributes(params[:trip])
      redirect_to(@trip, :notice => 'Trip was successfully updated.')
    else
      render :action => "edit"
    end
  end

  # DELETE /trips/1
  def destroy
    @trip = Trip.find(params[:id])
    @trip.destroy

    redirect_to(person_root_url)
  end

  def invite
    @trip = Trip.find(params[:id])
    @invitee = Person.find(:first, :conditions => [ "email = ?", params[:email]] )
    @trip.invitees << @invitee

    if @trip.save
      redirect_to(@trip, :notice => "Invited #{@invitee.name} to trip.")
    else
      render :action => "show"
    end
  end

  def join
    @trip = Trip.find(params[:id])
    logger.info("JOINING TRIP")
    @trip.participants << @trip.invitees.delete(current_person) unless !@trip.invitees.include?(current_person)
    if @trip.save
      redirect_to(@trip, :notice => "You joined trip #{@trip.name}.")
    else
      render :action => "show"
    end
  end
end
