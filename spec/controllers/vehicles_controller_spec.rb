require 'spec_helper'

describe VehiclesController do

  def mock_vehicle(stubs={})
    (@mock_vehicle ||= mock_model(Vehicle).as_null_object).tap do |vehicle|
      vehicle.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all vehicles as @vehicles" do
      Vehicle.stub(:all) { [mock_vehicle] }
      get :index
      assigns(:vehicles).should eq([mock_vehicle])
    end
  end

  describe "GET show" do
    it "assigns the requested vehicle as @vehicle" do
      Vehicle.stub(:find).with("37") { mock_vehicle }
      get :show, :id => "37"
      assigns(:vehicle).should be(mock_vehicle)
    end
  end

  describe "GET new" do
    it "assigns a new vehicle as @vehicle" do
      Vehicle.stub(:new) { mock_vehicle }
      get :new
      assigns(:vehicle).should be(mock_vehicle)
    end
  end

  describe "GET edit" do
    it "assigns the requested vehicle as @vehicle" do
      Vehicle.stub(:find).with("37") { mock_vehicle }
      get :edit, :id => "37"
      assigns(:vehicle).should be(mock_vehicle)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created vehicle as @vehicle" do
        Vehicle.stub(:new).with({'these' => 'params'}) { mock_vehicle(:save => true) }
        post :create, :vehicle => {'these' => 'params'}
        assigns(:vehicle).should be(mock_vehicle)
      end

      it "redirects to the created vehicle" do
        Vehicle.stub(:new) { mock_vehicle(:save => true) }
        post :create, :vehicle => {}
        response.should redirect_to(vehicle_url(mock_vehicle))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved vehicle as @vehicle" do
        Vehicle.stub(:new).with({'these' => 'params'}) { mock_vehicle(:save => false) }
        post :create, :vehicle => {'these' => 'params'}
        assigns(:vehicle).should be(mock_vehicle)
      end

      it "re-renders the 'new' template" do
        Vehicle.stub(:new) { mock_vehicle(:save => false) }
        post :create, :vehicle => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested vehicle" do
        Vehicle.should_receive(:find).with("37") { mock_vehicle }
        mock_vehicle.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :vehicle => {'these' => 'params'}
      end

      it "assigns the requested vehicle as @vehicle" do
        Vehicle.stub(:find) { mock_vehicle(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:vehicle).should be(mock_vehicle)
      end

      it "redirects to the vehicle" do
        Vehicle.stub(:find) { mock_vehicle(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(vehicle_url(mock_vehicle))
      end
    end

    describe "with invalid params" do
      it "assigns the vehicle as @vehicle" do
        Vehicle.stub(:find) { mock_vehicle(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:vehicle).should be(mock_vehicle)
      end

      it "re-renders the 'edit' template" do
        Vehicle.stub(:find) { mock_vehicle(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested vehicle" do
      Vehicle.should_receive(:find).with("37") { mock_vehicle }
      mock_vehicle.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the vehicles list" do
      Vehicle.stub(:find) { mock_vehicle }
      delete :destroy, :id => "1"
      response.should redirect_to(vehicles_url)
    end
  end

end
