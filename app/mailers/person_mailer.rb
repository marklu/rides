class PersonMailer < ActionMailer::Base
  default :from => "jku@cs169rides.com"
  def invitation_notification(invitee, invitation, trip)
    @invitee = invitee
    @invitation = invitation
    @trip = trip
    mail(:to => invitee.email, :subject => "You've been invited to join a trip.")
  end

  def new_user_invitation(invitation, trip)
    @trip = trip
    @invitation = invitation
    mail(:to => @invitation.email, :subject => "Register for our website and join the trip.")
  end
end
