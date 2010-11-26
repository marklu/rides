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

    it "is not valid without an address" do
      @trip.location = nil
      @trip.should_not be_valid
    end

    it "is not valid with an invalid address" do
      unstub_geocoder
      ['123 Address', '2222 Infinite Loop, Cupertino, CA', 'Infinite Loop, Cupertino, CA'].each do |address|
        @trip.location.address = address
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
  
  context "when generating arragements" do
    before(:each) do
      @driver_1 = create_valid("Person")
      @driver_1.stub!(:address).and_return("2650 Haste Street, Berkeley, CA")
      @driver_vehicle_1 = create_valid("Vehicle")
      @driver_vehicle_1.stub!(:owner).and_return(@driver_1)
      @driver_2 = create_valid("Person")
      @driver_2.email = "random@rand.org"
      @driver_2.stub!(:address).and_return("2650 Haste Street, Berkeley, CA")
      @driver_vehicle_2 = create_valid("Vehicle")
      @driver_vehicle_2.stub!(:owner).and_return(@driver_2)
      @participant_1 = create_valid("Person")
      @participant_1.email = "random2@rand.org"
      @participant_1.stub!(:address).and_return("2700 Hearst Avenue, Berkeley, CA")
      @participant_2 = create_valid("Person")
      @participant_2.email = "random3@rand.org"
      @participant_2.stub!(:address).and_return("2400 Durant Avenue, Berkeley, CA")
      @trip.stub!(:address).and_return("1920 San Pablo Avenue, Berkeley, CA")
    end
    
    it "should not save when there are no vehicles" do
      @trip.stub!(:vehicles).and_return([])
      @trip.should_not_receive(:save)
      @trip.generate_arrangements
    end
    
    it "should save when there are more people than vehicles" do
      @driver_vehicle_1.stub!(:capacity).and_return(2)
      @trip.stub!(:participants).and_return([@driver_1, @participant_1, @participant_2])
      @trip.stub!(:vehicles).and_return([@driver_vehicle_1])
      @trip.should_receive(:save)
      @trip.generate_arrangements
    end
    
    it "should save when there are enough vehicles to accommodate passengers" do
      @driver_vehicle_1.stub!(:capacity).and_return(2)
      @driver_vehicle_2.stub!(:capacity).and_return(2)
      @trip.stub!(:participants).and_return([@driver_1, @driver_2, @participant_1, @participant_2])
      @trip.stub!(:vehicles).and_return([@driver_vehicle_1, @driver_vehicle_2])
      @trip.should_receive(:save)
      @trip.generate_arrangements
    end
  end
end
