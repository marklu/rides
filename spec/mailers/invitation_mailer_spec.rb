require "spec_helper"

describe InvitationMailer do
  describe "Invitation Email" do
    before(:each) do
      @invitation = create_valid!('Invitation')
      @email = InvitationMailer.invitation(@invitation)
    end

    it "is delivered to the given email" do
      @email.should deliver_to(@invitation.email)
    end
  end
end
