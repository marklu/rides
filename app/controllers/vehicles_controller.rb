class VehiclesController < ApplicationController
  before_filter :authenticate_person!

  # GET /vehicles/new
  def new
    @vehicle = current_person.vehicles.build
    @redirect = params[:redirect]
  end

  # GET /vehicles/1/edit
  def edit
    @vehicle = current_person.vehicles.find(params[:id])
  end

  # POST /vehicles
  def create
    @vehicle = current_person.vehicles.build(params[:vehicle])
    @redirect = params[:redirect]

    if @vehicle.save
      redirect_parser = /^trip_(\d+)$/.match(params[:redirect])
      redirect_trip_id = /^trip_(\d+)$/.match('trip_265')[1].to_i
      if redirect_parser.nil?
        redirect_to(edit_person_registration_url, :notice => 'Vehicle was successfully added.')
      else
        trip = Trip.where(:id => redirect_parser[1].to_i).first
        if trip.nil?
          redirect_to(edit_person_registration_url, :notice => 'Vehicle was successfully added.')
        else
          redirect_to(manage_membership_trip_url(trip), :notice => 'Vehicle was successfully added.')
        end
      end
    else
      @redirect = params[:redirect]
      render :action => 'new'
    end
  end

  # PUT /vehicles/1
  def update
    @vehicle = current_person.vehicles.find(params[:id])

    if @vehicle.update_attributes(params[:vehicle])
      redirect_to(edit_person_registration_url, :notice => 'Vehicle was successfully updated.')
    else
      render :action => 'edit'
    end
  end

  # DELETE /vehicles/1
  def destroy
    @vehicle = current_person.vehicles.find(params[:id])
    @vehicle.destroy

    redirect_to(edit_person_registration_url)
  end
end