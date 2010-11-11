require 'spec_helper'

describe TripsController do
  before(:each) do
    @person = create_valid!("Person")
    @trip = create_valid!("Trip", :organizer => @person)
  end

  describe "GET index" do
    context "when not logged in" do
      it "redirects to the signin page" do
        get :index
        response.should redirect_to(:controller => "devise/sessions", :action => "new")
      end
    end
  end

  describe "GET show" do
    context "when not logged in" do
      it "redirects to the signin page" do
        get :show, :id => @trip.id
        response.should redirect_to(:controller => "devise/sessions", :action => "new")
      end
    end

    context "when logged in" do
      before(:each) do
        Trip.stub(:find).and_return(@trip)
        signin(@person)
      end

      it "finds the trip" do
        Trip.should_receive(:find).with(@trip.id).and_return(@trip)
        get :show, :id => @trip.id
      end

      it "renders the show template" do
        get :show, :id => @trip.id
        response.should render_template("show")
      end
    end
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

      it "assigns to @trip a new Trip" do
        get :new
        assigns[:trip].should be_an_instance_of(Trip)
        assigns[:trip].attributes.should == Trip.create(:organizer => @person).attributes
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
        get :edit, :id => @trip.id
        response.should redirect_to(:controller => "devise/sessions", :action => "new")
      end
    end

    context "when logged in" do
      before(:each) do
        @person.organized_trips.stub(:find).and_return(@trip)
        signin(@person)
      end

      it "finds the trip" do
        @person.organized_trips.should_receive(:find).with(@trip.id).and_return(@trip)
        get :edit, :id => @trip.id
      end

      it "renders the edit template" do
        get :edit, :id => @trip.id
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
        Trip.stub(:new).and_return(@trip)
        signin(@person)
      end

      it "creates a new trip with the given parameters" do
        Trip.should_receive(:new).with("name" => "Name").and_return(@trip)
        post :create, :trip => {"name" => "Name"}
      end

      it "saves the trip" do
        @trip.should_receive(:save)
        post :create
      end

      context "when the trip is successfully saved" do
        before(:each) do
          @trip.stub(:save).and_return(true)
        end

        it "sets a flash[:notice] message" do
          post :create
          flash[:notice].should == "Trip was successfully created."
        end

        it "redirects to the trip info page" do
          post :create
          response.should redirect_to(:action => "show", :id => @trip.id)
        end
      end

      context "when the trip fails to be saved" do
        before(:each) do
          @trip.stub(:save).and_return(false)
        end

        it "assigns to @trip the given trip" do
          post :create
          assigns[:trip].should be(@trip)
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
        put :update, :id => @trip.id
        response.should redirect_to(:controller => "devise/sessions", :action => "new")
      end
    end

    context "when logged in" do
      before(:each) do
        Trip.stub(:find).and_return(@trip)
        signin(@person)
      end

      it "finds the trip" do
        Trip.should_receive(:find).with(@trip.id).and_return(@trip)
        put :update, :id => @trip.id
      end

      it "updates the trip" do
        @trip.should_receive(:update_attributes).with("name" => "New Name")
        put :update, :id => @trip.id, :trip => {"name" => "New Name"}
      end

      context "when the trip is successfully updated" do
        before(:each) do
          @trip.stub(:update_attributes).and_return(true)
        end

        it "sets a flash[:notice] message" do
          put :update, :id => @trip.id
          flash[:notice].should == "Trip was successfully updated."
        end

        it "redirects to the trip info page" do
          put :update, :id => @trip.id
          response.should redirect_to(:action => "show", :id => @trip.id)
        end
      end

      context "when the trip fails to be updated" do
        before(:each) do
          @trip.stub(:update_attributes).and_return(false)
        end

        it "assigns to @trip the trip" do
          put :update, :id => @trip.id
          assigns[:trip].should be(@trip)
        end

        it "renders the edit template" do
          put :update, :id => @trip.id
          response.should render_template("edit")
        end
      end
    end
  end

  describe "DELETE destroy" do
    context "when not logged in" do
      it "redirects to the signin page" do
        delete :destroy, :id => @trip.id
        response.should redirect_to(:controller => "devise/sessions", :action => "new")
      end
    end

    context "when logged in" do
      before(:each) do
        Trip.stub(:find).and_return(@trip)
        signin(@person)
      end

      it "finds the trip" do
        Trip.should_receive(:find).with(@trip.id).and_return(@trip)
        delete :destroy, :id => @trip.id
      end

      it "destroys the trip" do
        @trip.should_receive(:destroy)
        delete :destroy, :id => @trip.id
      end

      it "redirects to the dashboard page" do
        delete :destroy, :id => @trip.id
        response.should redirect_to(:controller => "people", :action => "dashboard")
      end
    end
  end
end