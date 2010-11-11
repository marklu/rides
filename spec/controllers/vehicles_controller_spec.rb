require 'spec_helper'

describe VehiclesController do
  before(:each) do
    @person = create_valid!("Person")
    @vehicle = create_valid!("Vehicle", :owner => @person)
  end

  describe "GET new" do
    context "when not logged in" do
      it "redirects to the signin page" do
        get :new
        response.should redirect_to(:controller => "devise/sessions", :action => "new")
      end
    end

    context "when logged in" do
      before(:each) do
        signin(@person)
      end

      it "assigns to @vehicle a new Vehicle" do
        get :new
        assigns[:vehicle].should be_an_instance_of(Vehicle)
        assigns[:vehicle].attributes.should == Vehicle.create(:owner => @person).attributes
      end

      it "renders the new template" do
        get :new
        response.should render_template("new")
      end
    end
  end

  describe "GET edit" do
    context "when not logged in" do
      it "redirects to the signin page" do
        get :edit, :id => @vehicle.id
        response.should redirect_to(:controller => "devise/sessions", :action => "new")
      end
    end

    context "when logged in" do
      before(:each) do
        @person.vehicles.stub(:find).and_return(@vehicle)
        signin(@person)
      end

      it "finds the vehicle" do
        @person.vehicles.should_receive(:find).with(@vehicle.id).and_return(@vehicle)
        get :edit, :id => @vehicle.id
      end

      it "renders the edit template" do
        get :edit, :id => @vehicle.id
        response.should render_template("edit")
      end
    end
  end

  describe "POST create" do
    context "when not logged in" do
      it "redirects to the signin page" do
        post :create
        response.should redirect_to(:controller => "devise/sessions", :action => "new")
      end
    end

    context "when logged in" do
      before(:each) do
        Vehicle.stub(:new).and_return(@vehicle)
        signin(@person)
      end

      it "creates a new vehicle with the given parameters" do
        Vehicle.should_receive(:new).with("make" => "Make").and_return(@vehicle)
        post :create, :vehicle => {"make" => "Make"}
      end

      it "saves the vehicle" do
        @vehicle.should_receive(:save)
        post :create
      end

      context "when the vehicle is successfully saved" do
        before(:each) do
          @vehicle.stub(:save).and_return(true)
        end

        it "sets a flash[:notice] message" do
          post :create
          flash[:notice].should == "Vehicle was successfully added."
        end

        it "redirects to the edit profile page" do
          post :create
          response.should redirect_to(:controller => "devise/registrations", :action => "edit")
        end
      end

      context "when the vehicle fails to be saved" do
        before(:each) do
          @vehicle.stub(:save).and_return(false)
        end

        it "assigns to @vehicle a new vehicle" do
          post :create
          assigns[:vehicle].should be(@vehicle)
        end

        it "renders the new template" do
          post :create
          response.should render_template("new")
        end
      end
    end
  end

  describe "PUT update" do
    context "when not logged in" do
      it "redirects to the signin page" do
        put :update, :id => @vehicle.id
        response.should redirect_to(:controller => "devise/sessions", :action => "new")
      end
    end

    context "when logged in" do
      before(:each) do
        @person.vehicles.stub(:find).and_return(@vehicle)
        signin(@person)
      end

      it "finds the vehicle" do
        @person.vehicles.should_receive(:find).with(@vehicle.id).and_return(@vehicle)
        put :update, :id => @vehicle.id
      end

      it "updates the vehicle" do
        @vehicle.should_receive(:update_attributes).with("make" => "New Make")
        put :update, :id => @vehicle.id, :vehicle => {"make" => "New Make"}
      end

      context "when the vehicle is successfully updated" do
        before(:each) do
          @vehicle.stub(:update_attributes).and_return(true)
        end

        it "sets a flash[:notice] message" do
          put :update, :id => @vehicle.id
          flash[:notice].should == "Vehicle was successfully updated."
        end

        it "redirects to the edit profile page" do
          put :update, :id => @vehicle.id
          response.should redirect_to(:controller => "devise/registrations", :action => "edit")
        end
      end

      context "when the vehicle fails to be updated" do
        before(:each) do
          @vehicle.stub(:update_attributes).and_return(false)
        end

        it "assigns to @vehicle the vehicle" do
          put :update, :id => @vehicle.id
          assigns[:vehicle].should be(@vehicle)
        end

        it "renders the edit template" do
          put :update, :id => @vehicle.id
          response.should render_template("edit")
        end
      end
    end
  end

  describe "DELETE destroy" do
    context "when not logged in" do
      it "redirects to the signin page" do
        delete :destroy, :id => @vehicle.id
        response.should redirect_to(:controller => "devise/sessions", :action => "new")
      end
    end

    context "when logged in" do
      before(:each) do
        @person.vehicles.stub(:find).and_return(@vehicle)
        signin(@person)
      end

      it "finds the vehicle" do
        @person.vehicles.should_receive(:find).with(@vehicle.id).and_return(@vehicle)
        delete :destroy, :id => @vehicle.id
      end

      it "destroys the vehicle" do
        @vehicle.should_receive(:destroy)
        delete :destroy, :id => @vehicle.id
      end

      it "redirects to the edit profile page" do
        put :update, :id => @vehicle.id
        response.should redirect_to(:controller => "devise/registrations", :action => "edit")
      end
    end
  end
end