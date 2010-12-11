require 'spec_helper'
require 'digest/md5'

describe TripsController do
  before(:each) do
    @organizer = create_valid!(Person)
    @participant = create_valid!(Person)
    @person = create_valid!(Person)
    @trip = create_valid!(Trip, :organizers => [@organizer])
    @trip.participants << @participant
  end

  describe "GET index" do
    context "when not signed in" do
      it "redirects to the sign in page" do
        get :index
        response.should redirect_to(:controller => "devise/sessions", :action => "new")
      end
    end

    context "when signed in" do
      before(:each) do
        @upcoming_trip1 = create_valid!(Trip, 
          :name => 'Upcoming Trip 1',
          :time => Time.parse('January 5, 2012 10:00')
        )
        @upcoming_trip2 = create_valid!(Trip,
          :name => 'Upcoming Trip 2',
          :time => Time.parse('February 5, 2012 10:00')
        )
        @passed_trip1 = create_valid!(Trip,
          :name => 'Passed Trip 1',
          :time => Time.parse('January 5, 2009 10:00')
        )
        @passed_trip2 = create_valid!(Trip,
          :name => 'Passed Trip 2',
          :time => Time.parse('February 5, 2009 10:00')
        )
        @person.organized_trips << @upcoming_trip1 << @upcoming_trip2
        @person.trips << @passed_trip1 << @passed_trip2
        signin(@person)
      end

      context "when no month or an invalid month is given" do
        it "assigns to @trips a sorted list of trips in which @organizer is a participant" do
          get :index
          assigns[:trips].should == [@upcoming_trip2, @upcoming_trip1, @passed_trip2, @passed_trip1]
        end
      end

      context "when a valid month is given" do
        it "assigns to @trips a sorted list of trips occuring in the given month in which @organizer is a participant" do
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

  describe "GET show" do
    context "when not signed in" do
      it "redirects to the sign in page" do
        get :show, :id => @trip.id
        response.should redirect_to(:controller => "devise/sessions", :action => "new")
      end
    end

    context "when signed in as non-participant and non-organizer" do
      before(:each) do
        signin(@person)
      end

      it "redirects to the dashboard page" do
        get :show, :id => @trip.id
        response.should redirect_to(:controller => "people", :action => "dashboard")
      end
    end

    context "when signed in as a participant" do
      before(:each) do
        Trip.stub(:find).and_return(@trip)
        signin(@participant)
      end

      it "assigns to @trip the given trip" do
        Trip.should_receive(:find).with(@trip.id).and_return(@trip)
        get :show, :id => @trip.id
        assigns[:trip].should eq(@trip)
      end

      it "renders the show template" do
        get :show, :id => @trip.id
        response.should render_template("show")
      end
    end

    context "when signed in as an organizer" do
      before(:each) do
        Trip.stub(:find).and_return(@trip)
        signin(@organizer)
      end

      it "renders the show template" do
        get :show, :id => @trip.id
        response.should render_template("show")
      end
    end
  end

  describe "GET new" do
    context "when not signed in" do
      it "redirects to the sign in page" do
        get :new
        response.should redirect_to(:controller => "devise/sessions", :action => "new")
      end
    end

    context "when signed in" do
      before(:each) do
        signin(@person)
      end

      it "assigns to @trip a new Trip" do
        get :new
        assigns[:trip].should be_an_instance_of(Trip)
        assigns[:trip].attributes.should == Trip.create(:organizers => [@person]).attributes
      end

      it "renders the new template" do
        get :new
        response.should render_template("new")
      end
    end
  end

  describe "GET edit" do
    context "when not signed in" do
      it "redirects to the sign in page" do
        get :edit, :id => @trip.id
        response.should redirect_to(:controller => "devise/sessions", :action => "new")
      end
    end

    context "when signed in as non-participant and non-organizer" do
      before(:each) do
        signin(@person)
      end

      it "redirects to the dashboard page" do
        get :edit, :id => @trip.id
        response.should redirect_to(:controller => "people", :action => "dashboard")
      end
    end

    context "when signed in as participant" do
      before(:each) do
        signin(@participant)
      end

      it "redirects to the trip info page" do
        get :edit, :id => @trip.id
        response.should redirect_to(:controller => "trips", :action => "show", :id => @trip.id)
      end
    end

    context "when signed in as organizer" do
      before(:each) do
        @organizer.organized_trips.stub(:find).and_return(@trip)
        signin(@organizer)
      end

      it "assigns to @trip the given trip" do
        Trip.should_receive(:find).with(@trip.id).and_return(@trip)
        get :edit, :id => @trip.id
        assigns[:trip].should eq(@trip)
      end

      it "renders the edit template" do
        get :edit, :id => @trip.id
        response.should render_template("edit")
      end
    end
  end

  describe "POST create" do
    context "when not signed in" do
      it "redirects to the sign in page" do
        post :create
        response.should redirect_to(:controller => "devise/sessions", :action => "new")
      end
    end

    context "when signed in" do
      before(:each) do
        Trip.stub(:new).and_return(@trip)
        signin(@person)
      end

      it "assigns to @trip a new trip with the given parameters" do
        Trip.should_receive(:new).with("name" => "Name").and_return(@trip)
        post :create, :trip => {"name" => "Name"}
        assigns[:trip].should eq(@trip)
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
    context "when not signed in" do
      it "redirects to the sign in page" do
        put :update, :id => @trip.id
        response.should redirect_to(:controller => "devise/sessions", :action => "new")
      end
    end

    context "when signed in as non-participant and non-organizer" do
      before(:each) do
        signin(@person)
      end

      it "redirects to the dashboard page" do
        put :update, :id => @trip.id
        response.should redirect_to(:controller => "people", :action => "dashboard")
      end
    end

    context "when signed in as participant" do
      before(:each) do
        signin(@participant)
      end

      it "redirects to the trip info page" do
        put :update, :id => @trip.id
        response.should redirect_to(:controller => "trips", :action => "show", :id => @trip.id)
      end
    end

    context "when signed in as organizer" do
      before(:each) do
        Trip.stub(:find).and_return(@trip)
        signin(@organizer)
      end

      it "assigns to @trip the given trip" do
        Trip.should_receive(:find).with(@trip.id).and_return(@trip)
        put :update, :id => @trip.id
        assigns[:trip].should eq(@trip)
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


        it "renders the edit template" do
          put :update, :id => @trip.id
          response.should render_template("edit")
        end
      end
    end
  end

  describe "DELETE destroy" do
    context "when not signed in" do
      it "redirects to the sign in page" do
        delete :destroy, :id => @trip.id
        response.should redirect_to(:controller => "devise/sessions", :action => "new")
      end
    end

    context "when signed in as non-participant and non-organizer" do
      before(:each) do
        signin(@person)
      end

      it "redirects to the dashboard page" do
        delete :destroy, :id => @trip.id
        response.should redirect_to(:controller => "people", :action => "dashboard")
      end
    end

    context "when signed in as participant" do
      before(:each) do
        signin(@participant)
      end

      it "redirects to the trip info page" do
        delete :destroy, :id => @trip.id
        response.should redirect_to(:controller => "trips", :action => "show", :id => @trip.id)
      end
    end


    context "when signed in as organizer" do
      before(:each) do
        Trip.stub(:find).and_return(@trip)
        signin(@organizer)
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

  describe "GET participants" do
    context "when not signed in" do
      it "redirects to the sign in page" do
        get :participants, :id => 1
        response.should redirect_to(:controller => "devise/sessions", :action => "new")
      end
    end

    context "when signed in as non-participant and non-organizer" do
      before(:each) do
        signin(@person)
      end

      it "redirects to the dashboard page" do
        get :participants, :id => @trip.id
        response.should redirect_to(:controller => "people", :action => "dashboard")
      end
    end

    context "when signed in as participant" do
      before(:each) do
        signin(@participant)
      end

      it "renders the participants template" do
        get :participants, :id => @trip.id
        response.should render_template("participants")
      end
    end

    context "when signed in as an organizer" do
      before(:each) do
        @trip.participants.clear
        @participant1 = create_valid!(Person, :name => 'Allan', :email => 'allan@email.com')
        @participant2 = create_valid!(Person, :name => 'Baron', :email => 'baron@email.com')
        @participant3 = create_valid!(Person, :name => 'Chase', :email => 'chase@email.com')
        @trip.participants << @participant1 << @participant3 << @participant2
        @organizer2 = create_valid!(Person, :name => 'Zed', :email => 'zed@email.com')
        @trip.organizers << @organizer2
        signin(@organizer)
      end

      it "assigns to @invitees a sorted list of invited people" do
        @trip.stub(:invitees).and_return([{:name => 'b'}, {:name => 'a'}, {:name => 'c'}])
        Trip.stub(:find).and_return(@trip)
        get :participants, :id => @trip.id
        assigns[:invitees].map {|i| i[:name]}.should == ['a', 'b', 'c']
      end

      it "assigns to @organizers a sorted list of trip organizers" do
        get :participants, :id => @trip.id
        assigns[:organizers].should == [@organizer, @organizer2]
      end

      it "assigns to @participants a sorted list of trip participants" do
        get :participants, :id => @trip.id
        assigns[:participants].should == [@participant1, @participant2, @participant3]
      end

      it "assigns to @invitation a new invitation" do
        get :participants, :id => @trip.id
        assigns[:invitation].should be_an_instance_of(Invitation)
        assigns[:invitation].attributes.should == Invitation.new(:trip => @trip).attributes
      end

      it "renders the participants template" do
        get :participants, :id => @trip.id
        response.should render_template("participants")
      end
    end
  end

  describe "GET manage_membership" do
    context "when not signed in" do
      it "redirects to the sign in page" do
        get :manage_membership, :id => @trip.id
        response.should redirect_to(:controller => "devise/sessions", :action => "new")
      end
    end

    context "when signed in as non-participant and non-organizer" do
      before(:each) do
        signin(@person)
      end

      it "redirects to the dashboard page" do
        get :manage_membership, :id => @trip.id
        response.should redirect_to(:controller => "people", :action => "dashboard")
      end
    end

    context "when signed in as participant" do
      before(:each) do
        signin(@participant)
      end

      it "renders the manage_membership template" do
        get :manage_membership, :id => @trip.id
        response.should render_template("manage_membership")
      end
    end

    context "when signed in as an organizer" do
      before(:each) do
        signin(@organizer)
      end

      it "renders the manage_membership template" do
        get :manage_membership, :id => @trip.id
        response.should render_template("manage_membership")
      end
    end
  end

  describe "POST invite" do
    context "when not signed in" do
      it "redirects to the sign in page" do
        post :invite, :id => @trip.id
        response.should redirect_to(:controller => "devise/sessions", :action => "new")
      end
    end

    context "when signed in as non-participant and non-organizer" do
      before(:each) do
        signin(@person)
      end

      it "redirects to the dashboard page" do
        post :invite, :id => @trip.id
        response.should redirect_to(:controller => "people", :action => "dashboard")
      end
    end

    context "when signed in as participant" do
      before(:each) do
        signin(@participant)
      end

      it "redirects to the trip info page" do
        post :invite, :id => @trip.id
        response.should redirect_to(:controller => "trips", :action => "show", :id => @trip.id)
      end
    end

    context "when signed in as organizer" do
      before(:each) do
        @trip.participants.clear
        @invitation = create_valid!(Invitation)
        @participant1 = create_valid!(Person, :name => 'Allan', :email => 'allan@email.com')
        @participant2 = create_valid!(Person, :name => 'Baron', :email => 'baron@email.com')
        @participant3 = create_valid!(Person, :name => 'Chase', :email => 'chase@email.com')
        @trip.participants << @participant1 << @participant3 << @participant2
        @organizer2 = create_valid!(Person, :name => 'Zed', :email => 'zed@email.com')
        @trip.organizers << @organizer2
        signin(@organizer)
      end

      it "assigns to @invitation a new invitation with the given parameters" do
        Invitation.should_receive(:new).with("email" => @invitation.email).and_return(@invitation)
        post :invite, :id => @trip.id, :invitation => {"email" => @invitation.email}
        assigns[:invitation].should eq(@invitation)
      end

      it "marks the current person as the inviter" do
        post :invite, :id => @trip.id, :invitation => {"email" => @invitation.email}
        assigns[:invitation].inviter.should == @organizer.name
      end

      it "saves the invitation" do
        Invitation.stub(:new).and_return(@invitation)
        @invitation.should_receive(:save)
        post :invite, :id => @trip.id, :invitation => {"email" => @invitation.email}
      end

      context "when the invitation is successfully saved" do
        before(:each) do
          Invitation.stub(:new).and_return(@invitation)
          @invitation.stub(:save).and_return(true)
        end

        it "sets a flash[:notice] message" do
          post :invite, :id => @trip.id, :invitation => {"email" => @invitation.email}
          flash[:notice].should == "#{@invitation.email} has been invited."
        end

        it "redirects to the trip participants page" do
          post :invite, :id => @trip.id, :invitation => {"email" => @invitation.email}
          response.should redirect_to(:action => "participants", :id => @trip.id)
        end
      end

      context "when the invitation fails to be saved" do
        before(:each) do
          Invitation.stub(:new).and_return(@invitation)
          @invitation.stub(:save).and_return(false)
        end

        it "assigns to @organizers a sorted list of trip organizers" do
          post :invite, :id => @trip.id, :invitation => {"email" => @invitation.email}
          assigns[:organizers].should == [@organizer, @organizer2]
        end

        it "assigns to @participants a sorted list of trip participants" do
          post :invite, :id => @trip.id, :invitation => {"email" => @invitation.email}
          assigns[:participants].should == [@participant1, @participant2, @participant3]
        end
  
        it "assigns to @invitees a sorted list of invited people" do
          @trip.stub(:invitees).and_return([{:name => 'b'}, {:name => 'a'}, {:name => 'c'}])
          Trip.stub(:find).and_return(@trip)
          post :invite, :id => @trip.id, :invitation => {"email" => @invitation.email}
          assigns[:invitees].map {|i| i[:name]}.should == ['a', 'b', 'c']
        end

        it "renders the participants template" do
          post :invite, :id => @trip.id, :invitation => {"email" => @invitation.email}
          response.should render_template("participants")
        end
      end
    end
  end

  describe "GET join" do
    context "when not signed in" do
      it "redirects to the sign in page" do
        get :join, :id => @trip.id
        response.should redirect_to(:controller => "devise/sessions", :action => "new")
      end
    end

    context "when signed in as an invited non-participant and non-organizer" do
      before(:each) do
        Trip.stub(:find).and_return(@trip)
        @invited_person = create_valid!(Person)
        @invitation = create_valid!(Invitation, :trip => @trip)
        Invitation.stub(:find_by_token).and_return(@invitation)
        signin(@invited_person)
      end

      it "assigns to @trip the given trip" do
        Trip.should_receive(:find).and_return(@trip)
        get :join, :id => @trip.id
        assigns[:trip].should eq(@trip) 
      end

      it "assigns to @token the given token" do
        get :join, :id => @trip.id, :token => @invitation.token
        assigns[:token].should == @invitation.token
      end

      it "redirects to the dashboard page given an invalid token" do
        Invitation.stub(:find_by_token).and_return(nil)
        get :join, :id => @trip.id, :token => 'invalid'
        response.should redirect_to(:controller => "people", :action => "dashboard")
      end

      it "renders the join template" do
        get :join, :id => @trip.id, :token => @invitation.token
        response.should render_template("join")
      end
    end

    context "when signed in as a trip participant" do
      before(:each) do
        Trip.stub(:find).and_return(@trip)
        @trip.participants.stub(:include?).and_return(true)
        signin(@participant)
      end

      it "redirects to the trip info page" do
        get :join, :id => @trip.id, :token => 'token'
        response.should redirect_to(:controller => "trips", :action => "show", :id => @trip.id)
      end
    end
  end

  describe "POST join" do
    context "when not signed in" do
      it "redirects to the sign in page" do
        post :join, :id => @trip.id, :token => 'token'
        response.should redirect_to(:controller => "devise/sessions", :action => "new")
      end
    end

    context "when signed in as an invited non-participant and non-organizer" do
      before(:each) do
        Trip.stub(:find).and_return(@trip)
        @new_person = create_valid!(Person)
        @invitation = create_valid!(Invitation, :trip => @trip)
        Invitation.stub(:find_by_token).and_return(@invitation)
        signin(@new_person)
      end

      it "assigns to @trip the given trip" do
        Trip.should_receive(:find).and_return(@trip)
        post :join, :id => @trip.id
        assigns[:trip].should eq(@trip) 
      end

      it "redirects to the dashboard page given an invalid token" do
        Invitation.stub(:find_by_token).and_return(nil)
        post :join, :id => @trip.id, :token => 'invalid'
        response.should redirect_to(:controller => "people", :action => "dashboard")
      end

      it "accepts the invitation" do
        @invitation.should_receive(:accept).with(@new_person)
        post :join, :id => @trip.id, :token => @invitation.token
      end

      it "redirects to the manage membership page" do
        post :join, :id => @trip.id, :token => @invitation.token
        response.should redirect_to(:controller => "trips", :action => "manage_membership", :id => @trip.id)
      end
    end

    context "when signed in as a trip participant" do
      before(:each) do
        Trip.stub(:find).and_return(@trip)
        @trip.participants.stub(:include?).and_return(true)
        signin(@participant)
      end

      it "redirects to the trip info page" do
        post :join, :id => @trip.id, :token => 'token'
        response.should redirect_to(:controller => "trips", :action => "show")
      end
    end

    context "when signed in as a non-participant organizer" do
      before(:each) do
        Trip.stub(:find).and_return(@trip)
        @trip.organizers.stub(:include?).and_return(true)
        signin(@organizer)
      end

      it "adds the organizer to the list of participants" do
        post :join, :id => @trip.id
        @trip.participants.should include(@organizer)
      end

      it "redirects to the manage membership page" do
        post :join, :id => @trip.id
        response.should redirect_to(:controller => "trips", :action => "manage_membership")
      end
    end
  end

  describe "DELETE leave" do
    context "when not signed in" do
      it "redirects to the sign in page" do
        delete :leave, :id => @trip.id
        response.should redirect_to(:controller => "devise/sessions", :action => "new")
      end
    end

    context "when signed in as non-participant and non-organizer" do
      before(:each) do
        signin(@person)
      end

      it "redirects to the dashboard page" do
        delete :leave, :id => @trip.id
        response.should redirect_to(:controller => "people", :action => "dashboard")
      end
    end

    context "when signed in as a trip participant" do
      before(:each) do
        @vehicle = create_valid!(Vehicle, :owner => @participant)
        @trip.vehicles << @vehicle
        Trip.stub(:find).and_return(@trip)
        signin(@participant)
      end

      it "removes the participant from the trip" do
        delete :leave, :id => @trip.id
        @trip.participants.should_not include(@participant)
      end

      it "removes the participant's vehicles from the trip" do
        delete :leave, :id => @trip.id
        @trip.vehicles.should_not include(@vehicle)
      end

      it "redirects to the dashboard page" do
        delete :leave, :id => @trip.id
        response.should redirect_to(:controller => "people", :action => "dashboard")
      end
    end

    context "when signed in as an organizer and participant" do
      before(:each) do
        @vehicle = create_valid!(Vehicle, :owner => @organizer)
        @trip.vehicles << @vehicle
        Trip.stub(:find).and_return(@trip)
        @trip.participants << @organizer
        signin(@organizer)
      end

      it "removes the participant from the trip" do
        delete :leave, :id => @trip.id
        @trip.participants.should_not include(@organizer)
      end

      it "removes the participant's vehicles from the trip" do
        delete :leave, :id => @trip.id
        @trip.vehicles.should_not include(@vehicle)
      end

      it "redirects to the trip info page" do
        delete :leave, :id => @trip.id
        response.should redirect_to(:controller => "trips", :action => "show", :id => @trip.id)
      end
    end

    context "when signed in as a non-participant organizer" do
      before(:each) do
        signin(@organizer)
      end

      it "sets a flash[:alert] message" do
        delete :leave, :id => @trip.id
        flash[:alert].should == "You are not participating in #{@trip.name}"
      end

      it "redirects to the trip info page" do
        delete :leave, :id => @trip.id
        response.should redirect_to(:controller => "trips", :action => "show", :id => @trip.id)
      end
    end
  end

  describe "POST manage_vehicles" do
    context "when not signed in" do
      it "redirects to the sign in page" do
        post :manage_vehicles, :id => @trip.id
        response.should redirect_to(:controller => "devise/sessions", :action => "new")
      end
    end

    context "when signed in as non-participant and non-organizer" do
      before(:each) do
        signin(@person)
      end

      it "redirects to the dashboard page" do
        post :manage_vehicles, :id => @trip.id
        response.should redirect_to(:controller => "people", :action => "dashboard")
      end
    end

    context "when signed in as a non-participant organizer" do
      before(:each) do
        signin(@organizer)
      end

      it "sets a flash[:alert] message" do
        post :manage_vehicles, :id => @trip.id
        flash[:alert].should == "You are not participating in #{@trip.name}"
      end

      it "redirects to the trip info page" do
        post :manage_vehicles, :id => @trip.id
        response.should redirect_to(:controller => "trips", :action => "show", :id => @trip.id)
      end
    end

    context "when signed in as a trip participant" do
      before(:each) do
        @vehicle = create_valid!(Vehicle, :owner => @participant)
        signin(@participant)
      end

      context "given a valid vehicle" do
        it "adds the vehicle to the trip" do
          Trip.stub(:find).and_return(@trip)
          post :manage_vehicles, :id => @trip.id, :vehicle => @vehicle.id
          @trip.vehicles.should include(@vehicle)
        end

        it "redirects to the trip info page" do
          post :manage_vehicles, :id => @trip.id, :vehicle => @vehicle.id
          response.should redirect_to(:controller => "trips", :action => "show", :id => @trip.id)
        end
      end

      context "given an invalid vehicle" do
        it "sets a flash[:alert] message" do
          post :manage_vehicles, :id => @trip.id, :vehicle => 5000
          flash[:alert].should == "The vehicle you selected is invalid."
        end

        it "redirects to the manage membership page" do
          post :manage_vehicles, :id => @trip.id, :vehicle => 5000
          response.should redirect_to(:controller => "trips", :action => "manage_membership", :id => @trip.id)
        end
      end
    end
  end
end
