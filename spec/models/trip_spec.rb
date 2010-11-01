require 'spec_helper'

describe Trip do
  before(:each) do
    @current_user = mock_model(Person, {:id => 1})
  end
  
  describe "when validating a trip" do
    it "should not allow a trip with no organizer" do
      @no_organizer_attributes = {
        :time => Time.parse("Sun Oct 31 13:13 GMT 2010"),
        :address => "2650 Haste Street",
        :city => "Berkeley",
        :state => "CA"
      }
      
      @trip = Trip.new(@no_organizer_attributes)
      @trip.should_not be_valid
    end
    
    it "should not allow a trip with invalid organizer" do
      @invalid_organizer_attributes = {
        :organizer_id => "RAGE AGAINST THE SYSTEM"
        :time => Time.parse("Sun Oct 31 13:13 GMT 2010"),
        :address => "2650 Haste Street",
        :city => "Berkeley",
        :state => "CA"
      }
      
      @trip = Trip.new(@invalid_organizer_attributes)
      @trip.should_not be_valid
    end
    
    it "should not allow a trip with no name" do
      @no_name_attributes = {
        :organizer_id => @current_user.id,
        :time => Time.parse("Sun Oct 31 13:13 GMT 2010"),
        :address => "2650 Haste Street",
        :city => "Berkeley",
        :state => "CA"
      }
      
      @trip = Trip.new(@no_name_attributes)
      @trip.should_not be_valid
    end
    
    it "should not allow a trip with no time" do
      @no_time_attributes = {
        :organizer_id => @current_user.id,
        :name => "Epic Trip of Epicness",
        :address => "2650 Haste Street",
        :city => "Berkeley",
        :state => "CA"
      }
      
      @trip = Trip.new(@no_time_attributes)
      @trip.should_not be_valid
    end
    
    it "should not allow a trip with invalid time" do
      @invalid_time_attributes = {
        :organizer_id => @current_user.id,
        :name => "Epic Trip of Epicness",
        :time => "Invalid time!",
        :time => "This is not a time field sadly",
        :address => "2650 Haste Street",
        :city => "Berkeley",
        :state => "CA"
      }
      
      @trip = Trip.new(@invalid_time_attributes)
      @trip.should_not be_valid
    end
    
    it "should not allow a trip with no address" do
      @no_address_attributes = {
        :organizer_id => @current_user.id,
        :name => "Epic Trip of Epicness",
        :time => Time.parse("Sun Oct 31 13:13 GMT 2010"),
        :city => "Berkeley",
        :state => "CA"
      }
      
      @trip = Trip.new(@no_address_attributes)
      @trip.should_not be_valid
    end

#### Implement this test for later milestone   
#    it "should not allow a trip with invalid address" do
#      pending
#    end
    
    it "should not allow a trip with no city" do
      @no_address_attributes = {
        :organizer_id => @current_user.id,        
        :name => "Epic Trip of Epicness",
        :time => Time.parse("Sun Oct 31 13:13 GMT 2010"),
        :address => "2650 Haste Street",
        :state => "CA"
      }
      
      @trip = Trip.new(@no_address_attributes)
      @trip.should_not be_valid
    end
    
#### Implement this test for later milestone    
#    it "should not allow a trip with invalid city" do
#      pending
#    end
    
    it "should not allow a trip with no state" do
      @no_state_attributes = {
        :organizer_id => @current_user.id,        
        :name => "Epic Trip of Epicness",
        :time => Time.parse("Sun Oct 31 13:13 GMT 2010"),
        :address => "2650 Haste Street",
        :city => "Berkeley"
      }
      
      @trip = Trip.new(@no_state_attributes)
      @trip.should_not be_valid
    end

#### Implement this test for later milestone    
#    it "should not allow a trip with invalid state" do
#      pending
#    end
    
  end
  
  it "should create a new instance given valid attributes" do
    @valid_attributes = {
      :organizer_id => @current_user.id,      
      :name => "Epic Trip of Epicness",
      :time => Time.parse("Sun Oct 31 13:13 GMT 2010"),
      :address => "2650 Haste Street",
      :city => "Berkeley",
      :state => "CA"
    }
    
    Trip.create(@valid_attributes).should be_true
  end
  
  it "should not create a new instance given invalid attributes" do
    @invalid_attributes = {
      :organizer_id => "WHAT DID YOU SAY?",
      :name => "Rage!@!@%^%$^%$&%$&",
      :time => "Invalid Time",
      :address => "2650 Haste Street",
      :city => "Berkeley",
      :state => "CA"
    }
    
    Trip.create(@invalid_attributes).should be_false
  end
end
