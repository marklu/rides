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

  # POST /trips/1/invite
  def invite
    @trip = Trip.find(params[:id])
    @invitee = Person.find(:first, :conditions => [ "email = ?", params[:email] ])

    if (!@invitee)
      logger.info("Creating new person")
      @invitee = Person.create!({:email => params[:email],
          :name => nil,
          :phone => nil,
          :address => nil,
          :password => "temppassword",
          :music => 'no_preference',
          :smoking => 'no_preference'
      })
    end

    if @trip.participants.include?(@invitee)
      flash[:notice] = "Error: #{@invitee.name} is already a participant of that trip."
      render :action => "show"
      return
    else
      invitation = @trip.invite!(@invitee)
    end

    if @trip.save
      PersonMailer.invitation_notification(@invitee).deliver
      redirect_to(@trip, :notice => "Invited #{@invitee.email} to trip.")
    else
      if (duplicate_error = invitation.errors[:pending_trip_id][0])
        flash[:notice] = duplicate_error
      end
      
      render :action => "show"
    end
  end

  # GET /trips/1/join
  def join
    @trip = Trip.find(params[:id])
    @trip.participants << @trip.invitees.delete(current_person) unless !@trip.invitees.include?(current_person)
    @trip.vehicles << current_person.vehicles.first unless current_person.vehicles.empty?
    if @trip.save
      redirect_to(@trip, :notice => "You joined trip #{@trip.name}.")
    else
      render :action => "show"
    end
  end
end
