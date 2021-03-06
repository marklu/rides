require 'spec_helper'

describe Arrangement do
  before(:each) do
    @arrangement = create_valid!(Arrangement)
  end

  context "when validating" do
    it "is valid with valid attributes" do
      @arrangement.should be_valid
    end

    it "is not valid without a trip" do
      @arrangement.trip = nil
      @arrangement.should_not be_valid
    end

    it "is not valid without an origin" do
      @arrangement.origin = nil
      @arrangement.should_not be_valid
    end

    it "is not valid without a destination" do
      @arrangement.destination = nil
      @arrangement.should_not be_valid
    end

    it "is not valid without a vehicle" do
      @arrangement.vehicle = nil
      @arrangement.should_not be_valid
    end
  end

  context "when destroying" do
    it "destroys its destination location" do
      @arrangement.destination.should_receive(:destroy)
      @arrangement.destroy
    end

    it "destroys its origin location" do
      @arrangement.origin.should_receive(:destroy)
      @arrangement.destroy
    end
  end

  context "when determining incompatibility" do
    context "with annother arrangement" do
      before(:each) do
        @arrangement_preferences = Preferences.create!
        @arrangement.stub(:preferences).and_return(@arrangement_preferences)
        @other = create_valid!(Arrangement)
        @other_preferences = Preferences.create!
        @other.stub(:preferences).and_return(@other_preferences)
      end

      it "compares the other arrangement's preferences with its own" do
        @arrangement_preferences.should_receive(:incompatibility_with).with(@other_preferences)
        @arrangement.incompatibility_with(@other)
      end
    end

    context "with a person" do
      before(:each) do
        @arrangement_preferences = Preferences.create!
        @arrangement.stub(:preferences).and_return(@arrangement_preferences)
        @other = create_valid!(Person)
        @other_preferences = Preferences.create!
        @other.stub(:preferences).and_return(@other_preferences)
      end
  
      it "compares the person's preferences with its own" do
        @arrangement_preferences.should_receive(:incompatibility_with).with(@other_preferences)
        @arrangement.incompatibility_with(@other)
      end
    end

    context "when has no driver" do
      it "has neutral preferences" do
        preferences = @arrangement.preferences
        [:music, :smoking].each do |preference|
          preferences.send(preference).should == 'no_preference'
        end
      end
    end

    context "when has a driver" do
      before(:each) do
        @preferences = Preferences.create!
        @arrangement.stub_chain(:driver, :preferences).and_return(@preferences)
      end

      it "has the same preferences as the driver" do
        @arrangement.preferences.should eq(@preferences)
      end
    end
  end

  it "has a driver: its vehicle's owner" do
    @arrangement.driver.should eq(@arrangement.vehicle.owner)
  end

  it "has capacity equal to its vehicle's passenger capacity" do
    @arrangement.capacity.should == @arrangement.vehicle.passenger_capacity
  end

  it "is full when its number of passengers is >= its capacity" do
    [
      [@arrangement.capacity - 1, false],
      [@arrangement.capacity, true],
      [@arrangement.capacity + 1, true]
    ].each do |capacity, bool|
      @arrangement.passengers.stub(:count).and_return(capacity)
      @arrangement.full?.should == bool
    end
  end
end
