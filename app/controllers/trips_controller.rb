class TripsController < ApplicationController
  before_filter :authenticate_person!
  load_resource :except => [:index, :new, :create]
  before_filter :check_abilities, :except => [:index, :new, :create, :join]

  # GET /trips
  def index
    unless params[:month].nil? || params[:year].nil?
      @trips = current_person.trips.select do |trip|
        trip.time.month == params[:month].to_i && trip.time.year == params[:year].to_i
      end
    else
      @trips = current_person.trips
    end
    @trips = @trips.sort {|x, y| x.time <=> y.time}.reverse

    @months_with_trips = current_person.trips.map {|trip| trip.time}.sort.reverse
      .map {|time| {:month => time.month, :year => time.year}}
      .uniq
  end

  # GET /trips/1
  def show
  end

  # GET /trips/new
  def new
    @trip = current_person.organized_trips.build
  end

  # GET /trips/1/edit
  def edit
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
    if @trip.update_attributes(params[:trip])
      redirect_to(@trip, :notice => 'Trip was successfully updated.')
    else
      render :action => "edit"
    end
  end

  # DELETE /trips/1
  def destroy
    @trip.destroy
    redirect_to(person_root_url)
  end

  # GET /trips/1/participants
  def participants
    @participants = @trip.participants.sort_by {|participant| participant.name}
    @invitees = @trip.invitees.sort
    @invitation = @trip.invitations.build
  end

  # POST /trips/1/invite
  def invite
    @invitation = @trip.invitations.build(params[:invitation])
    if @invitation.save
      redirect_to(participants_trip_url(@trip), :notice => "#{params[:invitation][:email]} has been invited.")
    else
      @participants = @trip.participants.sort_by {|participant| participant.name}
      @invitees = @trip.invitees.sort
      render :action => 'participants'
    end
  end

  # GET /trips/1/join
  # POST /trips/1/join
  def join
    if @trip.participants.include?(current_person)
      redirect_to(@trip, :notice => "You are already a participant in the #{@trip.name}.")
      return
    end

    @token = params[:token]
    invitation = Invitation.find_by_token(@token)
    if invitation.nil?
      redirect_to(person_root_url, :error => "The invitation link you followed is invalid.")
      return
    end

    if request.post?
      invitation.accept(current_person)
      redirect_to(@trip, :notice => "You are now a participant in the #{@trip.name}.")
    end
  end

  # DELETE /trips/1/leave
  def leave
    @trip.participants.delete(current_person)
    redirect_to(person_root_url, :notice => "You are no longer participating in #{@trip.name}")
  end

  private

  def check_abilities
    authorize!(params[:action].to_sym, @trip || Trip)
  end
end
