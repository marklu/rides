require 'spec_helper'

describe Invitation do

  before(:each) do
    @trip = create_valid!("Trip")
    @invitation = create_valid("Invitation")
    @invitation.pending_trip = @trip
  end

  context "when validating" do
    it "is valid with valid attributes" do
      @invitation.should be_valid
    end

    it "is not valid without a pending trip" do
      pending
      @invitation.pending_trip = nil
      @invitation.should_not be_valid
    end

    it "is not valid without a token" do
      @invitation.token = nil
      @invitation.should_not be_valid
    end

    it "is not valid without an email" do
      @invitation.email = nil
      @invitation.should_not be_valid
    end

    it "is not valid when there is another invitation with the same email and pending trip" do
      @trip = create_valid!("Trip")

      @invitation1 = create_valid("Invitation",
        :email => "asdf@asdf.com")
      @invitation1.pending_trip = @trip
      @invitation1.save!
      @invitation2 = create_valid("Invitation",
        :email => "asdf@asdf.com")
      @invitation2.pending_trip = @trip
      @invitation2.should_not be_valid
    end
  end
end

