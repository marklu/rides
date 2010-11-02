require 'spec_helper'

describe Person do

  before(:each) do
    #    @current_user = mock_model(Person, {:id => 1})
  end
  #  attr_accessible :email, :password, :password_confirmation, :name, :phone,
  #    :address, :city, :state, :music, :smoking

  describe "when validating a person" do

    it "should create a new instance given valid attributes" do
      @valid_attributes= {
        :email => "test@test.com",
        :password => "testpassword",
        :password_confirmation => "testpassword",
        :name => "John Test",
        :phone => "123-456-7890",
        :address => "123 Main St.",
        :city => "Testville",
        :state => "CA",
        :music => "no_preference",
        :smoking => "no_preference"
      }
      Person.create(@valid_attributes).should be_true
    end

    it "should not allow a person with no name" do
      @no_name_attributes = {
        :email => "test@test.com",
        :password => "testpassword",
        :password_confirmation => "testpassword",
        #        :name => "John Test",
        :phone => "123-456-7890",
        :address => "123 Main St.",
        :city => "Testville",
        :state => "CA",
        :music => "no_preference",
        :smoking => "no_preference"
      }
      @person = Person.new(@no_name_attributes)
      @person.should_not be_valid
    end

    it "should not allow a person with no email" do
      @no_email_attributes = {
        #        :email => "test@test.com",
        :password => "testpassword",
        :password_confirmation => "testpassword",
        :name => "John Test",
        :phone => "123-456-7890",
        :address => "123 Main St.",
        :city => "Testville",
        :state => "CA",
        :music => "no_preference",
        :smoking => "no_preference"
      }
      @person = Person.new(@no_email_attributes)
      @person.should_not be_valid
    end

    it "should not allow a person with an invalid email" do
      @invalid_email_1_attributes = {
        :email => "invalidemail",
        :password => "testpassword",
        :password_confirmation => "testpassword",
        :name => "John Test",
        :phone => "123-456-7890",
        :address => "123 Main St.",
        :city => "Testville",
        :state => "CA",
        :music => "no_preference",
        :smoking => "no_preference"
      }
      @person1 = Person.new(@invalid_email_1_attributes)
      @person1.should_not be_valid

      @invalid_email_2_attributes = {
        :email => "invalidemail@test",
        :password => "testpassword",
        :password_confirmation => "testpassword",
        :name => "John Test",
        :phone => "123-456-7890",
        :address => "123 Main St.",
        :city => "Testville",
        :state => "CA",
        :music => "no_preference",
        :smoking => "no_preference"
      }
      @person2 = Person.new(@invalid_email_2_attributes)
      @person2.should_not be_valid
    end

    it "should not allow a person with no password" do
      @no_password_attributes = {
        :email => "test@test.com",
        #        :password => "testpassword",
        #        :password_confirmation => "testpassword",
        :name => "John Test",
        :phone => "123-456-7890",
        :address => "123 Main St.",
        :city => "Testville",
        :state => "CA",
        :music => "no_preference",
        :smoking => "no_preference"
      }
      @person = Person.new(@no_password_attributes)
      @person.should_not be_valid
    end

    it "should not allow a person with a password that is too short" do
      @no_password_attributes = {
        :email => "test@test.com",
        :password => "srt",
       :password_confirmation => "srt",
        :name => "John Test",
        :phone => "123-456-7890",
        :address => "123 Main St.",
        :city => "Testville",
        :state => "CA",
        :music => "no_preference",
        :smoking => "no_preference"
      }
      @person = Person.new(@no_password_attributes)
      @person.should_not be_valid
    end


    it "should not allow a person with mismatched password and password confirmation" do
      @mismatched_password_attributes = {
        :email => "test@test.com",
        :password => "testpassword",
        :password_confirmation => "wrongpassword",
        :name => "John Test",
        :phone => "123-456-7890",
        :address => "123 Main St.",
        :city => "Testville",
        :state => "CA",
        :music => "no_preference",
        :smoking => "no_preference"
      }
      @person = Person.new(@mismatched_password_attributes)
      @person.should_not be_valid
    end

    it "should not allow a person with no phone" do
      @no_phone_attributes = {
        :email => "test@test.com",
        :password => "testpassword",
        :password_confirmation => "testpassword",
        :name => "John Test",
        #        :phone => "123-456-7890",
        :address => "123 Main St.",
        :city => "Testville",
        :state => "CA",
        :music => "no_preference",
        :smoking => "no_preference"
      }
      @person = Person.new(@no_phone_attributes)
      @person.should_not be_valid
    end

    it "should not allow a person with no address" do
      @no_address_attributes = {
        :email => "test@test.com",
        :password => "testpassword",
        :password_confirmation => "testpassword",
        :name => "John Test",
        :phone => "123-456-7890",
#        :address => "123 Main St.",
        :city => "Testville",
        :state => "CA",
        :music => "no_preference",
        :smoking => "no_preference"
      }
      @person = Person.new(@no_address_attributes)
      @person.should_not be_valid
    end

    it "should not allow a person with no city" do
      @no_city_attributes = {
        :email => "test@test.com",
        :password => "testpassword",
        :password_confirmation => "testpassword",
        :name => "John Test",
        :phone => "123-456-7890",
        :address => "123 Main St.",
#        :city => "Testville",
        :state => "CA",
        :music => "no_preference",
        :smoking => "no_preference"
      }
      @person = Person.new(@no_city_attributes)
      @person.should_not be_valid
    end

    it "should not allow a person with no state" do
      @no_state_attributes = {
        :email => "test@test.com",
        :password => "testpassword",
        :password_confirmation => "testpassword",
        :name => "John Test",
        :phone => "123-456-7890",
        :address => "123 Main St.",
        :city => "Testville",
#        :state => "CA",
        :music => "no_preference",
        :smoking => "no_preference"
      }
      @person = Person.new(@no_state_attributes)
      @person.should_not be_valid
    end

  end


end
