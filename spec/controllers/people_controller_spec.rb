require 'spec_helper'

describe PeopleController do
  before(:each) do
    @person = create_valid!("Person")
  end

  describe "GET index" do
    context "when not logged in" do
      it "renders the index template" do
        get :index
        response.should render_template("index")
      end
    end

    context "when logged in" do
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
    context "when not logged in" do
      it "redirects to the signin page" do
        get :dashboard
        response.should redirect_to(:controller => "devise/sessions", :action => "new")
      end
    end

    context "when logged in" do
      before(:each) do
        signin(@person)
      end

      it "assigns to @upcoming_trips a list of upcoming trips" do
        trips = [stub_model(Trip), stub_model(Trip)]
        @person.stub(:upcoming_trips).and_return(trips)
        get :dashboard
        assigns[:upcoming_trips].should eq(trips)
      end

      it "renders the dashboard template" do
        get :dashboard
        response.should render_template("dashboard")
      end
    end
  end
end