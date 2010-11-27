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

    context "when logged in" do
      before(:each) do
        @organizer = create_valid!('Person', :email => 'organizer@email.com')
        @upcoming_trip1 = @organizer.organized_trips.create!(
          :name => 'Upcoming Trip 1',
          :address => '795 Folsom Street, San Francisco, CA',
          :time => Time.parse('January 5, 2012 10:00')
        )
        @upcoming_trip2 = @organizer.organized_trips.create!(
          :name => 'Upcoming Trip 2',
          :address => '1475 Folsom Street, San Francisco, CA',
          :time => Time.parse('February 5, 2012 10:00')
        )
        @passed_trip1 = @organizer.organized_trips.create!(
          :name => 'Passed Trip 1',
          :address => '1601 South California Avenue, Palo Alto, California',
          :time => Time.parse('January 5, 2009 10:00')
        )
        @passed_trip2 = @organizer.organized_trips.create!(
          :name => 'Passed Trip 2',
          :address => '329 East Jimmie Leeds Road, Absecon, NJ',
          :time => Time.parse('February 5, 2009 10:00')
        )
        @person.stub(:trips).and_return([@upcoming_trip1, @upcoming_trip2, @passed_trip1, @passed_trip2])
        signin(@person)
      end

      context "when no month or an invalid month is given" do
        it "assigns to @trips a list of trips in which @person is a participant" do
          get :index
          assigns[:trips].should == [@upcoming_trip1, @upcoming_trip2, @passed_trip1, @passed_trip2]
        end
      end

      context "when a valid month is given" do
        it "assigns to @trips a list of trips occuring in the given month in which @person is a participant" do
          get :index, :month => 1, :year => 2012
          assigns[:trips].should == [@upcoming_trip1]
        end
      end

      it "assigns to @months_with_trips a sorted list of months in which a trip occured" do
        get :index
        assigns[:months_with_trips].should == [
          {'month' => 2, 'year' => 2012},
          {'month' => 1, 'year' => 2012},
          {'month' => 2, 'year' => 2009},
          {'month' => 1, 'year' => 2009}
        ]
      end

      it "renders the index template" do
        get :index
        response.should render_template("index")
      end
    end
  end

  describe "GET participants" do
    context "when not logged in" do
      it "redirects to the signin page" do
        get :participants, :id => 1
        response.should redirect_to(:controller => "devise/sessions", :action => "new")
      end
    end

    context "when logged in as trip organizer" do
      before(:each) do
        @participant1 = create_valid!('Person', :name => 'Allan', :email => 'allan@email.com')
        @participant2 = create_valid!('Person', :name => 'Baron', :email => 'baron@email.com')
        @participant3 = create_valid!('Person', :name => 'Chase', :email => 'chase@email.com')
        @trip.participants << @participant1 << @participant3 << @participant2
        signin(@person)
      end

      it "assigns to @participants a sorted list of trip participants" do
        get :participants, :id => @trip.id
        assigns[:participants].should == [@participant1, @participant2, @participant3]
      end

      it "renders the participants template" do
        get :participants, :id => @trip.id
        response.should render_template("participants")
      end
    end

    context "when logged in as trip participant" do
      before(:each) do
        @participant1 = create_valid!('Person', :name => 'Allan', :email => 'allan@email.com')
        @participant2 = create_valid!('Person', :name => 'Baron', :email => 'baron@email.com')
        @participant3 = create_valid!('Person', :name => 'Chase', :email => 'chase@email.com')
        @trip.participants << @participant1 << @participant3 << @participant2
        signin(@participant1)
      end

      it "assigns to @participants a sorted list of trip participants" do
        get :participants, :id => @trip.id
        assigns[:participants].should == [@participant1, @participant2, @participant3]
      end

      it "renders the participants template" do
        get :participants, :id => @trip.id
        response.should render_template("participants")
      end
    end
  end

  describe "DELETE participants" do
    context "when not logged in" do
      it "redirects to the signin page" do
        delete :leave, :id => 1
        response.should redirect_to(:controller => "devise/sessions", :action => "new")
      end
    end

    context "when logged in as a trip participant" do
      before(:each) do
        @participant = create_valid!('Person', :email => 'participant@email.com')
        @trip.participants << @participant
        signin(@participant)
      end

      it "removes the participant from the trip" do
        Trip.stub(:find).and_return(@trip)
        delete :leave, :id => @trip.id
        @trip.participants.should_not include(@participant)
      end

      it "redirects to the dashboard page" do
        delete :leave, :id => @trip.id
        response.should redirect_to(:controller => "people", :action => "dashboard")
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

  describe "POST invite" do
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
        @invitee = create_valid!("Person", :name => 'Mr. Invitee', :email => 'invitee@invitee.com')
        #        @invitation = @trip.invitations.build(:email => 'invitee@invitee.com', :token => @trip.id)
#        @invitation = stub_model(Invitation,
#          :created_at => Time.now,
#          :updated_at => Time.now,
#          :pending_trip_id => @trip.id,
#          :email => @invitee.email,
#          :token => @trip.id)
        @invitation  = create_valid!("Invitation", :pending_trip => @trip, :email => @invitee.email, :token => @trip.id)
      end

      it "finds the trip" do
        Trip.should_receive(:find).with(@trip.id).and_return(@trip)
        post :invite, :id => @trip.id, :invitation => {:email => @invitee.email}
      end

      it "creates the invitation" do
        Invitation.stub(:new).and_return(@invitation)
        @invitation.should_receive(:save).twice.and_return(true)
        post :invite, :id => @trip.id, :invitation => {:email => @invitee.email}
      end

      it "finds the person" do
        Person.stub(:find).and_return(@person)
        post :invite, :id => @trip.id, :invitation => {:email => @invitee.email}
        assigns[:invitee].should eq(@person)
      end


      it "saves the trip" do
        @trip.should_receive(:save).and_return(true)
        post :invite, :id => @trip.id, :invitation => {:email => @invitee.email}
      end

      it "sets a flash[:notice] message" do
        post :invite, :id => @trip.id, :invitation => {:email => @invitee.email}
        flash[:notice].should == "Invited #{@invitee.email} to trip."
      end

      it "adds the invitee to trip's list of invitees" do
        post :invite, :id => @trip.id, :invitation => {:email => @invitee.email}
        @invitee.should be_invited_to(@trip)
      end

      it "adds the trip to invitee's list of pending trips" do
        pending
        post :invite, :id => @trip.id, :invitation => {:email => @invitee.email}
        @invitee.pending_trips.should include(@trip)
      end

      it "redirects to the show trip info page" do
        post :invite, :id => @trip.id, :invitation => {:email => @invitee.email}
        response.should redirect_to(:action => "show", :id => @trip.id)
      end
    end
  end
end