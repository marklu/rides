class VehiclesController < ApplicationController
  before_filter :authenticate_person!

  # GET /vehicles/1
  # GET /vehicles/1.xml
  def show
    @vehicle = current_person.vehicles.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @vehicle }
    end
  end

  # GET /vehicles/new
  # GET /vehicles/new.xml
  def new
    @vehicle = current_person.vehicles.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @vehicle }
    end
  end

  # GET /vehicles/1/edit
  def edit
    @vehicle = current_person.vehicles.find(params[:id])
  end

  # POST /vehicles
  # POST /vehicles.xml
  def create
    @vehicle = current_person.vehicles.build(params[:vehicle])

    respond_to do |format|
      if @vehicle.save
        format.html { redirect_to(edit_person_registration_url, :notice => 'Vehicle was successfully added.') }
        format.xml  { render :xml => @vehicle, :status => :created, :location => @vehicle }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @vehicle.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /vehicles/1
  # PUT /vehicles/1.xml
  def update
    @vehicle = current_person.vehicles.find(params[:id])

    respond_to do |format|
      if @vehicle.update_attributes(params[:vehicle])
        format.html { redirect_to(edit_person_registration_url, :notice => 'Vehicle was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @vehicle.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /vehicles/1
  # DELETE /vehicles/1.xml
  def destroy
    @vehicle = current_person.vehicles.find(params[:id])
    @vehicle.destroy

    respond_to do |format|
      format.html { redirect_to(edit_person_registration_url) }
      format.xml  { head :ok }
    end
  end
end