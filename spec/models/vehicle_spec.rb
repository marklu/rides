require 'spec_helper'

describe Vehicle do
  before(:each) do
    @vehicle = create_valid(Vehicle)
  end

  context "when validating" do
    it "is valid with valid attributes" do
      @vehicle.should be_valid
    end

    it "is not valid without a make" do
      @vehicle.make = ''
      @vehicle.should_not be_valid
    end

    it "is not valid without a model" do
      @vehicle.model = ''
      @vehicle.should_not be_valid
    end

    it "is not valid without a capacity" do
      @vehicle.capacity = ''
      @vehicle.should_not be_valid
    end

    it "is not valid with an invalid capacity" do
      [-1, 0, 5.5, "string"].each do |invalid_capacity|
        @vehicle.capacity = invalid_capacity
        @vehicle.should_not be_valid
      end
    end

    it "is not valid without an owner" do
      @vehicle.owner = nil
      @vehicle.should_not be_valid
    end
  end

  it "has passenger capacity: total capacity - 1" do
    @vehicle.passenger_capacity.should == @vehicle.capacity - 1
  end
end
