require 'spec_helper'

describe ArrangementsController do
  before(:each) do
    @trip = create_valid!(Trip)
    @passenger1 = build_valid(Person,
      :location => build_valid(Location, :latitude => 37.866054, :longitude => -122.254856)
    )
    @passenger2 = build_valid(Person,
      :location => build_valid(Location, :latitude => 37.8555404, :longitude => -122.2664398)
    )
    @arrangement = build_valid(Arrangement,
      :origin => build_valid(Location, :latitude => 37.875535, :longitude => -122.255618),
      :destination => build_valid(Location, :latitude => 37.867417, :longitude => -122.260408),
      :trip => @trip
    )
    @trip.organizers << @passenger1
    @trip.participants << @passenger1 << @passenger2 << @arrangement.driver
    @trip.vehicles << @arrangement.vehicle
  end

  describe "POST generate" do
    context "when not signed in" do
      it "redirects to the sign in page" do
        post :generate, :trip_id => @trip.id
        response.should redirect_to(:controller => "devise/sessions", :action => "new")
      end
    end

    context "when signed in as non-participant and non-organizer" do
      before(:each) do
        @person = create_valid!(Person)
        signin(@person)
      end

      it "redirects to the dashboard page" do
        post :generate, :trip_id => @trip.id
        response.should redirect_to(:controller => "people", :action => "dashboard")
      end
    end

    context "when signed in as a non-organizer participant" do
      before(:each) do
        signin(@passenger2)
      end

      it "redirects to the trip info page" do
        post :generate, :trip_id => @trip.id
        response.should redirect_to(:controller => "trips", :action => "show", :id => @trip.id)
      end
    end

    context "when signed in as an organizer" do
      before(:each) do
        signin(@passenger1)
      end

      context "when there are not enough vehicles" do
        before(:each) do
          @trip.participants << create_valid(Person) << create_valid(Person)
        end

        it "sets a flash[:alert] message" do
          post :generate, :trip_id => @trip.id
          flash[:alert].should == "There are not enough cars to generate arrangements"
        end

        it "redirects to the arrangements page" do
          post :generate, :trip_id => @trip.id
          response.should redirect_to(:controller => "arrangements", :action => "index", :trip_id => @trip.id)
        end
      end

      context "when there are enough vehicles" do
        it "generates a ride arrangement" do
          Trip.stub(:find).and_return(@trip)
          post :generate, :trip_id => @trip.id
          @trip.arrangements.first.passengers.should include(@passenger1)
          @trip.arrangements.first.passengers.should include(@passenger2)
        end

        it "sets a flash[:notice] message" do
          post :generate, :trip_id => @trip.id
          flash[:notice].should == "Arrangements have been generated"
        end

        it "redirects to the arrangements page" do
          post :generate, :trip_id => @trip.id
          response.should redirect_to(:controller => "arrangements", :action => "index", :trip_id => @trip.id)
        end
      end
    end
  end
end
