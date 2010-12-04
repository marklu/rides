require 'spec_helper'

describe Invitation do
  before(:each) do
    @invitation = create_valid!('Invitation')
  end

  context "when validating" do
    it "is valid with valid attributes" do
      @invitation.should be_valid
    end

    it "is not valid without an email" do
      @invitation.email = ''
      @invitation.should_not be_valid
    end

    it "is not valid with an invalid email" do
      ["invalidemail", "invalidemail@test"].each do |invalid_email|
        @invitation.email = invalid_email
        @invitation.should_not be_valid
      end
    end

    it "is not valid when there is another invitation for the same email and trip" do
      @invitation2 = build_valid('Invitation',
        :email => @invitation.email,
        :trip => @invitation.trip
      )
      @invitation2.should_not be_valid
    end

    it "is valid when there is another invitation for the same email but different trip" do
      @invitation2 = create_valid!('Invitation', :email => @invitation.email)
      @invitation2.should be_valid
    end

    it "is valid when there is another invitation for a different email but same trip" do
      @invitation2 = create_valid!('Invitation', :trip => @invitation.trip)
      @invitation2.should be_valid
    end

    it "is not valid without a token" do
      @invitation.token = ''
      @invitation.should_not be_valid
    end

    it "is not valid with a non-unique token" do
      @invitation2 = build_valid('Invitation', :token => @invitation.token)
      @invitation2.should_not be_valid
    end

    it "is not valid without a trip" do
      @invitation.trip = nil
      @invitation.should_not be_valid
    end

    it "is not valid with an invalid trip" do
      @invitation.trip.destroy
      @invitation.should_not be_valid
    end
  end
end
