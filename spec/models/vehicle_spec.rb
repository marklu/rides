require 'spec_helper'

describe Vehicle do

  before(:each) do
    @owner = mock_model(Person, {:id => 1})
  end
  #  create_table "vehicles", :force => true do |t|
  #    t.integer  "capacity"
  #    t.datetime "created_at"
  #    t.datetime "updated_at"
  #    t.integer  "owner_id"
  #    t.string   "make"
  #    t.string   "model"
  #  end

  describe "when validating a vehicle" do

    it "should create a new instance given valid attributes" do
      @valid_attributes = {
        :capacity => 5,
        :owner_id => @owner.id,
        :make => "Toyota",
        :model => "Camry"
      }
      Vehicle.create(@valid_attributes).should be_true
    end

    it "should not allow a vehicle without capacity" do
      @no_capacity_attributes = {
        #        :capacity => 5,
        :owner_id => @owner.id,
        :make => "Toyota",
        :model => "Camry"
      }
      Vehicle.new(@no_capacity_attributes).should_not be_valid
    end

    it "should not allow a vehicle with non-numeric capacity" do
      @no_owner_attributes = {
        :capacity => "lol",
        :owner_id => @owner.id,
        :make => "Toyota",
        :model => "Camry"
      }
      Vehicle.new(@no_owner_attributes).should_not be_valid
    end

    it "should not allow a vehicle with noninteger capacity" do
      @no_owner_attributes = {
        :capacity => 5.5,
        :owner_id => @owner.id,
        :make => "Toyota",
        :model => "Camry"
      }
      Vehicle.new(@no_owner_attributes).should_not be_valid
    end

    it "should not allow a vehicle with zero capacity" do
      @no_owner_attributes = {
        :capacity => 0,
        :owner_id => @owner.id,
        :make => "Toyota",
        :model => "Camry"
      }
      Vehicle.new(@no_owner_attributes).should_not be_valid
    end

    it "should not allow a vehicle without owner" do
      @no_owner_attributes = {
        :capacity => 5,
        #        :owner_id => @owner.id,
        :make => "Toyota",
        :model => "Camry"
      }
      Vehicle.new(@no_owner_attributes).should_not be_valid
    end

    it "should not allow a vehicle without make" do
      @no_make_attributes = {
        :capacity => 5,
        :owner_id => @owner.id,
        #        :make => "Toyota",
        :model => "Camry"
      }
      Vehicle.new(@no_make_attributes).should_not be_valid
    end

    it "should not allow a vehicle without model" do
      @no_model_attributes = {
        :capacity => 5,
        :owner_id => @owner.id,
        :make => "Toyota"
#        :model => "Camry"
      }
      Vehicle.new(@no_model_attributes).should_not be_valid
    end

  end


end
