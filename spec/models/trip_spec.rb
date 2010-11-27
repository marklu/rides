require 'spec_helper'

describe Trip do
  before(:each) do
    @trip = create_valid("Trip")
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

    it "is not valid without an organizer" do
      @trip.organizer = nil
      @trip.should_not be_valid
    end

    it "is not valid with an invalid organizer" do
      @trip.organizer.destroy
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
