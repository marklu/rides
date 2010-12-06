require 'spec_helper'

describe Invitation do
  before(:each) do
    @invitation = create_valid!(Invitation)
    @new_invitation = build_valid(Invitation)
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
      @invitation2 = build_valid(Invitation,
        :email => @invitation.email,
        :trip => @invitation.trip
      )
      @invitation2.should_not be_valid
    end

    it "is valid when there is another invitation for the same email but different trip" do
      @invitation2 = create_valid!(Invitation, :email => @invitation.email)
      @invitation2.should be_valid
    end

    it "is valid when there is another invitation for a different email but same trip" do
      @invitation2 = create_valid!(Invitation, :trip => @invitation.trip)
      @invitation2.should be_valid
    end

    it "is not valid without a token" do
      @invitation.token = ''
      @invitation.should_not be_valid
    end

    it "is not valid with a non-unique token" do
      @invitation2 = create_valid!(Invitation)
      @invitation2.token = @invitation.token
      @invitation2.should_not be_valid
    end

    it "is not valid without a trip" do
      @invitation.trip = nil
      @invitation.should_not be_valid
    end
  end

  context "when creating" do
    it "generates a token" do
      @new_invitation.should_receive(:generate_token)
      @new_invitation.save
    end

    it "sends the invitation" do
      @new_invitation.should_receive(:send_invitation)
      @new_invitation.save
    end
  end

  context "when generating a token" do
    it "generates a token" do
      @new_invitation.generate_token
      @new_invitation.token.should == Digest::MD5.hexdigest(@new_invitation.email + @new_invitation.trip.id.to_s)
    end

    it "generates a unique token" do
      @invitation.email, @new_invitation.email = "newemail@email.com", @invitation.email
      @invitation.save && @new_invitation.save
      @new_invitation.token.should_not == @invitation.token
    end
  end

  context "when sending invitation" do
    it "sends an invitation email" do
      InvitationMailer.should_receive(:invitation).with(@new_invitation).and_return(double('email', :deliver => true))
      @new_invitation.send_invitation
    end
  end

  context "when accepting the invitation" do
    before(:each) do
      @person = create_valid!(Person)
    end

    it "adds the given person to the trip" do
      @invitation.accept(@person)
      @invitation.trip.participants.should include(@person)
    end

    it "destroys itself" do
      @invitation.should_receive(:destroy)
      @invitation.accept(@person)
    end
  end
end
