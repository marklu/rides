class InvitationMailer < ActionMailer::Base
  def invitation(invitation)
    @invitation = invitation
    mail(
      :from => 'invitations@cs169rides.com',
      :to => @invitation.email,
      :subject => "Invitation to Participate in the #{@invitation.trip.name}"
    )
  end
end
