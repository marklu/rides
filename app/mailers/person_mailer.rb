class PersonMailer < ActionMailer::Base
  default :from => "jku@cs169rides.com"
  def invitation_notification(invitation, trip)
    @invitation = invitation
    @trip = trip
    mail(:to => @invitation.email, :subject => "You've been invited to join a trip.")
  end

end
