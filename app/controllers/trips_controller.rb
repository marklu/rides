class TripsController < ApplicationController
  before_filter :authenticate_person!
  load_resource :except => [:index, :new, :create]
  before_filter :check_abilities, :except => [:index, :new, :create, :join]

  # GET /trips
  def index
    @trips = (current_person.trips | current_person.organized_trips).sort {|x, y| x.time <=> y.time}.reverse
    unless params[:month].nil? || params[:year].nil?
      @trips = @trips.select {|t| t.time.month == params[:month].to_i && t.time.year == params[:year].to_i}
    end
    @months_with_trips = @trips.map {|t| t.time}.sort.reverse.map {|t| {:month => t.month, :year => t.year}}.uniq
  end

  # GET /trips/1
  def show
  end

  # GET /trips/new
  def new
    @trip = Trip.new(:organizers => [current_person])
  end

  # GET /trips/1/edit
  def edit
  end

  # POST /trips
  def create
    @trip = Trip.new(params[:trip])
    @trip.organizers << current_person
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
    @invitees = @trip.invitees.sort_by {|invitee| invitee[:name]}
    @organizers = @trip.organizers.sort_by {|organizer| organizer.name}
    @participants = @trip.participants.sort_by {|participant| participant.name}
    @invitation = @trip.invitations.build
  end

  # GET /trips/1/membership
  def manage_membership
  end

  # POST /trips/1/invite
  def invite
    @invitation = @trip.invitations.build(params[:invitation])
    @invitation.inviter = current_person.name
    if @invitation.save
      redirect_to(participants_trip_url(@trip), :notice => "#{params[:invitation][:email]} has been invited.")
    else
      @invitees = @trip.invitees.sort_by {|invitee| invitee[:name]}
      @organizers = @trip.organizers.sort_by {|organizer| organizer.name}
      @participants = @trip.participants.sort_by {|participant| participant.name}
      render :action => 'participants'
    end
  end

  # GET /trips/1/join
  # POST /trips/1/join
  def join
    if @trip.participants.include?(current_person)
      redirect_to(@trip, :notice => "You are already a participant in the #{@trip.name}.")
      return
    elsif @trip.organizers.include?(current_person) && request.post?
      @trip.participants << current_person
      redirect_to(manage_membership_trip_url(@trip), :notice => "You are now a participant in the #{@trip.name}.")
    else
      @token = params[:token]
      invitation = Invitation.find_by_token(@token)
      if invitation.nil?
        redirect_to(person_root_url, :error => "The invitation link you followed is invalid.")
        return
      end
  
      if request.post?
        invitation.accept(current_person)
        redirect_to(manage_membership_trip_url(@trip), :notice => "You are now a participant in the #{@trip.name}.")
      end
    end
  end

  # DELETE /trips/1/leave
  def leave
    unless @trip.participants.include?(current_person)
      redirect_to(@trip, :alert => "You are not participating in #{@trip.name}")
      return
    end

    @trip.participants.delete(current_person)
    @trip.vehicles.reject! {|v| v.owner == current_person}
    if @trip.organizers.include?(current_person)
      redirect_to(@trip, :notice => "You are no longer participating in #{@trip.name}")
    else
      redirect_to(person_root_url, :notice => "You are no longer participating in #{@trip.name}")
    end
  end

  # POST /trips/1/vehicles
  def manage_vehicles
    unless @trip.participants.include?(current_person)
      redirect_to(@trip, :alert => "You are not participating in #{@trip.name}")
      return
    end

    vehicle = params[:vehicle].nil? ? nil :
              current_person.vehicles.where(:id => params[:vehicle].to_i).first
    if vehicle.nil?
      redirect_to(manage_membership_trip_url(@trip), :alert => "The vehicle you selected is invalid.")
    else
      @trip.vehicles << vehicle
      redirect_to(@trip, :notice => "You are now a driver for the #{@trip.name}.")
    end
  end

  private

  def check_abilities
    authorize!(params[:action].to_sym, @trip || Trip)
  end
end
