require 'spec_helper'

describe PeopleController do
  before(:each) do
    @person = create_valid!("Person")
  end

  describe "GET index" do
    context "when not signed in" do
      it "renders the index template" do
        get :index
        response.should render_template("index")
      end
    end

    context "when signed in" do
      before(:each) do
        signin(@person)
      end

      it "redirects to the dashboard page" do
        get :index
        response.should redirect_to(:action => "dashboard")
      end
    end
  end

  describe "GET dashboard" do
    context "when not signed in" do
      it "redirects to the sign in page" do
        get :dashboard
        response.should redirect_to(:controller => "devise/sessions", :action => "new")
      end
    end

    context "when signed in" do
      before(:each) do
        signin(@person)
      end

      it "assigns to @upcoming_trips a sorted list of upcoming trips" do
        trips = [
          stub_model(Trip, :time => Time.now),
          stub_model(Trip, :time => Time.now + 1000),
          stub_model(Trip, :time => Time.now + 2000),
          stub_model(Trip, :time => Time.now + 3000)
        ]
        @person.stub(:upcoming_trips).and_return(trips.shuffle)
        get :dashboard
        assigns[:upcoming_trips].should == trips
      end

      it "renders the dashboard template" do
        get :dashboard
        response.should render_template("dashboard")
      end
    end
  end
end