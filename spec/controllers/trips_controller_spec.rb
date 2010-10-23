require 'spec_helper'

describe TripsController do

  def mock_trip(stubs={})
    (@mock_trip ||= mock_model(Trip).as_null_object).tap do |trip|
      trip.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all trips as @trips" do
      Trip.stub(:all) { [mock_trip] }
      get :index
      assigns(:trips).should eq([mock_trip])
    end
  end

  describe "GET show" do
    it "assigns the requested trip as @trip" do
      Trip.stub(:find).with("37") { mock_trip }
      get :show, :id => "37"
      assigns(:trip).should be(mock_trip)
    end
  end

  describe "GET new" do
    it "assigns a new trip as @trip" do
      Trip.stub(:new) { mock_trip }
      get :new
      assigns(:trip).should be(mock_trip)
    end
  end

  describe "GET edit" do
    it "assigns the requested trip as @trip" do
      Trip.stub(:find).with("37") { mock_trip }
      get :edit, :id => "37"
      assigns(:trip).should be(mock_trip)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created trip as @trip" do
        Trip.stub(:new).with({'these' => 'params'}) { mock_trip(:save => true) }
        post :create, :trip => {'these' => 'params'}
        assigns(:trip).should be(mock_trip)
      end

      it "redirects to the created trip" do
        Trip.stub(:new) { mock_trip(:save => true) }
        post :create, :trip => {}
        response.should redirect_to(trip_url(mock_trip))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved trip as @trip" do
        Trip.stub(:new).with({'these' => 'params'}) { mock_trip(:save => false) }
        post :create, :trip => {'these' => 'params'}
        assigns(:trip).should be(mock_trip)
      end

      it "re-renders the 'new' template" do
        Trip.stub(:new) { mock_trip(:save => false) }
        post :create, :trip => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested trip" do
        Trip.should_receive(:find).with("37") { mock_trip }
        mock_trip.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :trip => {'these' => 'params'}
      end

      it "assigns the requested trip as @trip" do
        Trip.stub(:find) { mock_trip(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:trip).should be(mock_trip)
      end

      it "redirects to the trip" do
        Trip.stub(:find) { mock_trip(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(trip_url(mock_trip))
      end
    end

    describe "with invalid params" do
      it "assigns the trip as @trip" do
        Trip.stub(:find) { mock_trip(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:trip).should be(mock_trip)
      end

      it "re-renders the 'edit' template" do
        Trip.stub(:find) { mock_trip(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested trip" do
      Trip.should_receive(:find).with("37") { mock_trip }
      mock_trip.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the trips list" do
      Trip.stub(:find) { mock_trip }
      delete :destroy, :id => "1"
      response.should redirect_to(trips_url)
    end
  end

end
