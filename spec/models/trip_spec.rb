require 'spec_helper'

describe Trip do
  before(:each) do
    @trip_organizer = Person.create(
      :email => 'email@email.com',
      :password => 'testpassword123',
      :password_confirmation => 'testpassword123',
      :name => 'John Test',
      :phone => '123-456-7890',
      :address => '123 Main St.',
      :city => 'Testville',
      :state => 'CA',
    )
    @attributes = {
      :name => "Some Trip",
      :time => Time.now,
      :address => "1234 Main St",
      :city => "Berkeley",
      :state => "CA",
      :organizer => @trip_organizer
    }
    @trip = Trip.create(@attributes)
  end

  context "when validating" do
    it "is valid with valid attributes" do
      @trip.should be_valid
    end

    it "is not valid without a name" do
      @trip.name = nil
      @trip.should_not be_valid
    end

    it "is not valid without a time" do
      @trip.time = nil
      @trip.should_not be_valid
    end

    it "is not valid with an invalid time" do
      [20, "string"].each do |time|
        @trip.time = time
        @trip.should_not be_valid
      end
    end

    it "is not valid without an address" do
      @trip.address = nil
      @trip.should_not be_valid
    end

    it "is not valid with an invalid address"

    it "is not valid without a city" do
      @trip.city = nil
      @trip.should_not be_valid
    end

    it "is not valid with an invalid city"

    it "is not valid without a state" do
      @trip.state = nil
      @trip.should_not be_valid
    end

    it "is not valid with an invalid state"

    it "is not valid without an organizer" do
      @trip.organizer = nil
      @trip.should_not be_valid
    end

    it "is not valid with an invalid organizer" do
      @trip_organizer.destroy
      @trip.should_not be_valid
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
end
