require 'spec_helper'

describe Location do
  before(:each) do
    unstub_geocoder
    @location = Location.create!(:location => '1 Infinite Loop, Cupertino, CA')
  end

  context "when validating" do
    it "is not valid without a location" do
      @location.location = nil
      @location.should_not be_valid
    end

    it "is not valid with an invalid location" do
      ['123 Address', '2222 Infinite Loop, Cupertino, CA', 'Infinite Loop, Cupertino, CA'].each do |location|
        @location.location = location
        @location.should_not be_valid
      end
    end
  end

  context "after creating" do
    it "has a latitude and longitude" do
      @location.latitude.should == 37.33191
      @location.longitude.should == -122.031262
    end
  end

  describe "#distance_to" do
    it "returns the distance from one location to another location" do
      @other = Location.create!(:location => '1600 Amphitheatre Pkwy, Mountain View, CA')
      @location.distance_to(@other).should == 6.934837206234292
    end
  end

  after(:each) do
    stub_geocoder
  end
end
