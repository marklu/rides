require 'spec_helper'

describe Trip do
  before(:each) do
    @current_user = mock_model(Person, {:id => 1})
    @past_trip_attributes = {
      :organizer => @trip_organizer,
      :name => "Some Trip",
      :time => Time.now() - 1000,
      :address => "1234 Main St",
      :city => "Berkeley",
      :state => "CA"
    }
    @future_trip_attributes = {
      :organizer => @trip_organizer,
      :name => "Some Trip",
      :time => Time.now() + 1000,
      :address => "1234 Main St",
      :city => "Berkeley",
      :state => "CA"
    }
    @person_attributes = {
      :name => "Test User",
      :address => "1234 Main St",
      :city => "Testville",
      :state => "CA",
      :phone => "1234567890",
      :email => "test@example.com",
      :password => "Test123!"
    }
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
        :organizer_id => "RAGE AGAINST THE SYSTEM",
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

  describe "when checking upcoming trips for a person" do
    it "should return all upcoming trips that the person is a participant in" do
      @trip_organizer = Person.create!(@person_attributes.update({:name => "Trip Organizer", :email => "organizer@example.com"}))
      @participant = Person.create!(@person_attributes.update({:name => "Trip Participant", :email => "participant@example.com"}))
      
      @first_trip = Trip.create!(@future_trip_attributes.update({:organizer => @trip_organizer}))
      @second_trip = Trip.create!(@future_trip_attributes.update({:organizer => @trip_organizer}))

      @first_trip.participants.push @participant
      @second_trip.participants.push @participant

      @first_trip.stub!(:upcoming?).and_return true
      @second_trip.stub!(:upcoming?).and_return true

      @upcoming_trips = Trip.upcoming_for(@participant)
      @upcoming_trips.should include @first_trip
      @upcoming_trips.should include @second_trip
    end
    
    it "should not return trips that are not upcoming" do
      @participant = Person.create!(@person_attributes.update({:name => "Trip Participant", :email => "participant@example.com"}))
      @past_trip = Trip.create!(@past_trip_attributes)
      @past_trip.participants.push @participant
      
      @past_trip.stub!(:upcoming?).and_return false

      Trip.upcoming_for(@participant).should_not include @past_trip
    end

    it "should not return trips that the person is not participating in" do
      @participant = Person.create!(@person_attributes.update({:name => "Trip Participant", :email => "participant@example.com"}))
      @trip = Trip.create!(@future_trip_attributes)
      @trip.participants.stub!(:include?).with(@participant).and_return false
      
      Trip.upcoming_for(@participant).should_not include @trip
    end
  end
  
  describe "when determining if a trip is upcoming" do
    it "should be upcoming when the trip is in the future" do
      @trip = Trip.new(@future_trip_attributes)
      @trip.upcoming?.should be_true
    end
    it "should not be upcoming when the trip is in the past" do
      @trip = Trip.new(@past_trip_attributes)
      @trip.upcoming?.should be_false
    end
  end
end
