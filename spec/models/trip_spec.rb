require 'spec_helper'

describe Trip do
  before(:each) do
    @trip = create_valid!(Trip)
  end

  context "when validating" do
    it "is valid with valid attributes" do
      @trip.should be_valid
    end

    it "is not valid without a name" do
      @trip.name = ''
      @trip.should_not be_valid
    end

    it "is not valid without a time" do
      @trip.time = ''
      @trip.should_not be_valid
    end

    it "is not valid with an invalid time" do
      [20, "string"].each do |time|
        @trip.time = time
        @trip.should_not be_valid
      end
    end

    it "is not valid without an location" do
      @trip.location = nil
      @trip.should_not be_valid
    end

    it "is not valid with an invalid location" do
      unstub_geocoder
      ['123 Address', '2222 Infinite Loop, Cupertino, CA', 'Infinite Loop, Cupertino, CA'].each do |location|
        @trip.location.location = location
        @trip.should_not be_valid
      end
      stub_geocoder
    end

    it "is not valid without any organizers" do
      @trip.organizers.clear
      @trip.should_not be_valid
    end
  end

  context "when destroying" do
    it "destroys its arrangements" do
      arrangement1 = create_valid!(Arrangement, :trip => @trip)
      arrangement2 = create_valid!(Arrangement, :trip => @trip)
      @trip.destroy
      @trip.arrangements.count.should == 0
    end

    it "destroys its location" do
      @trip.location.should_receive(:destroy)
      @trip.destroy
    end

    it "destroys its invitations" do
      invitation1 = create_valid!(Invitation, :trip => @trip)
      invitation2 = create_valid!(Invitation, :trip => @trip)
      @trip.destroy
      @trip.invitations.count.should == 0
    end
  end

  context "when upcoming" do
    before(:each) do
      @trip.time = Time.now + 1200000
    end
    
    it "is upcoming" do
      @trip.should be_upcoming
    end
  end

  context "when passed" do
    before(:each) do
      @trip.time = Time.now - 1200000
    end
    
    it "is not upcoming" do
      @trip.should_not be_upcoming
    end
  end

  context "when many people have been invited to join" do
    before(:each) do
      @invitation1 = create_valid!(Invitation, :invitee => 'Invitee 1', :trip => @trip)
      @invitation2 = create_valid!(Invitation, :invitee => 'Invitee 2', :trip => @trip)
    end

    it "has a list of invitees" do
      @trip.invitees.map {|i| i[:name]}.sort.should == ['Invitee 1', 'Invitee 2']
    end

    it "has the name, email, and role of each invitee" do
      invitee = @trip.invitees.find {|i| i[:name] == 'Invitee 1'}
      invitee[:email] = @invitation1.email
      invitee[:role] = @invitation1.role
    end
  end

  context "when has many organizers and participants" do
    before(:each) do
      @participant = create_valid(Person)
      @trip.participants << @participant
      @organizer = create_valid(Person)
      @trip.organizers << @organizer
      @participant_organizer = create_valid(Person)
      @trip.participants << @participant_organizer
      @trip.organizers << @participant_organizer
    end

    it "knows the role of each organizer or participant" do
      @trip.roles_for(@participant).should == ['participant']
      @trip.roles_for(@organizer).should == ['organizer']
      @trip.roles_for(@participant_organizer).sort.should == ['organizer', 'participant']
    end
  end
end
