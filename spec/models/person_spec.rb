require 'spec_helper'

describe Person do
  before(:each) do
    @person = create_valid("Person")
  end

  context "when creating" do
    it "does not allow an empty password" do
      create_valid("Person",
        :password => '',
        :password_confirmation => ''
      ).should_not be_valid
    end

    it "does not allow a password shorter than 6 characters" do
      create_valid("Person",
        :password => "12345",
        :password_confirmation => "12345"
      ).should_not be_valid
    end

    it "does not allow a mismatch between password and password confirmation" do
      create_valid("Person",
        :password => "testpassword123",
        :password_confirmation => "differentpassword456"
      ).should_not be_valid
    end

    it "does not allow an empty password confirmation" do
      create_valid("Person", :password_confirmation => '').should_not be_valid
    end

    it "sets the music preference to 'No Preference' by default" do
      create_valid("Person", :music => nil).music.should == 'no_preference'
    end

    it "sets the smoking preference to 'No Preference' by default" do
      create_valid("Person", :smoking => nil).smoking.should == 'no_preference'
    end
  end

  context "when validating" do
    it "is valid with valid attributes" do
      @person.should be_valid
    end

    it "is not valid without an email" do
      @person.email = ''
      @person.should_not be_valid
    end

    it "is not valid with an invalid email" do
      ["invalidemail", "invalidemail@test"].each do |invalid_email|
        @person.email = invalid_email
        @person.should_not be_valid
      end
    end

    it "is not valid without a name" do
      @person.name = ''
      @person.should_not be_valid
    end

    it "is not valid without a phone" do
      @person.phone = ''
      @person.should_not be_valid
    end

    it "is not valid with an invalid phone number" do
      ['12345678900', 'aaaaaaaaaa'].each do |phone|
        @person.phone = phone
        @person.should_not be_valid
      end
    end

    it "is not valid without an address" do
      @person.address = ''
      @person.should_not be_valid
    end

    it "is not valid with an invalid address" do
      pending
      unstub_geocoder
      ['123 Address', '2222 Infinite Loop, Cupertino, CA', 'Infinite Loop, Cupertino, CA'].each do |address|
        @person.address = address
        @person.should_not be_valid
      end
      stub_geocoder
    end

    it "is valid with a valid music preference (No Preference, No Music, Quiet Music, Loud Music)" do
      ['no_preference', 'no_music', 'quiet_music', 'loud_music'].each do |preference|
        @person.music = preference
        @person.should be_valid
      end
    end

    it "is not valid with an invalid music preference" do
      ['No Preference', 'invalid', '0'].each do |preference|
        @person.music = preference
        @person.should_not be_valid
      end
    end

    it "is valid with a valid smoking preference (No Preference, No Smoking, Smoking)" do
      ['no_preference', 'no_smoking', 'smoking'].each do |preference|
        @person.smoking = preference
        @person.should be_valid
      end
    end

    it "is not valid with an invalid smoking preference" do
      ['No Preference', 'invalid', '0'].each do |preference|
        @person.smoking = preference
        @person.should_not be_valid
      end
    end
  end

  context "when organizing many trips" do
    before(:each) do
      @trip1 = create_valid!("Trip", :organizer => @person)
      @trip2 = create_valid!("Trip", :organizer => @person)
    end

    it "has a list of organized trips" do
      @person.organized_trips.should include(@trip1)
      @person.organized_trips.should include(@trip2)
    end
  end

  context "when participating in many trips" do
    before(:each) do
      @trip1 = stub_model(Trip)
      @trip2 = stub_model(Trip)
      @person.trips << @trip1
      @person.trips << @trip2
    end

    it "has a list of trips" do
      @person.trips.should include(@trip1)
      @person.trips.should include(@trip2)
    end

    it "has a list of upcoming trips" do
      @trip1.stub(:upcoming?).and_return(true)
      @trip2.stub(:upcoming?).and_return(true)
      @person.upcoming_trips.should include(@trip1)
      @person.upcoming_trips.should include(@trip2)
    end

    it "does not have passed trips in its list of upcoming trips" do
      @trip1.stub(:upcoming?).and_return(false)
      @trip2.stub(:upcoming?).and_return(true)
      @person.upcoming_trips.should_not include(@trip1)
    end
  end

  context "when has many vehicles" do
    before(:each) do
      @vehicle1 = stub_model(Vehicle)
      @vehicle2 = stub_model(Vehicle)
      @person.vehicles << @vehicle1
      @person.vehicles << @vehicle2
    end

    it "has a list of vehicles" do
      @person.vehicles.should include(@vehicle1)
      @person.vehicles.should include(@vehicle2)
    end
  end
end
