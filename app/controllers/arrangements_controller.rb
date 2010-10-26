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

  # GET /arrangements/new
  # GET /arrangements/new.xml
  def new
    @arrangement = @trip.arrangements.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @arrangement }
    end
  end

  # GET /arrangements/1/edit
  def edit
    @arrangement = @trip.arrangements.find(params[:id])
  end

  # POST /arrangements
  # POST /arrangements.xml
  def create
    @arrangement = @trip.arrangements.build(params[:arrangement])

    respond_to do |format|
      if @arrangement.save
        format.html { redirect_to([@trip, @arrangement], :notice => 'Arrangement was successfully created.') }
        format.xml  { render :xml => @arrangement, :status => :created, :location => @arrangement }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @arrangement.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /arrangements/1
  # PUT /arrangements/1.xml
  def update
    @arrangement = @trip.arrangements.find(params[:id])

    respond_to do |format|
      if @arrangement.update_attributes(params[:arrangement])
        format.html { redirect_to([@trip, @arrangement], :notice => 'Arrangement was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @arrangement.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /arrangements/1
  # DELETE /arrangements/1.xml
  def destroy
    @arrangement = @trip.arrangements.find(params[:id])
    @arrangement.destroy

    respond_to do |format|
      format.html { redirect_to(trip_arrangements_path(@trip)) }
      format.xml  { head :ok }
    end
  end

  private

  def get_trip
    @trip = Trip.find(params[:trip_id])
  end
end
