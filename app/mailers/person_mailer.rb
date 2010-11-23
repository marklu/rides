class PersonMailer < ActionMailer::Base
  default :from => "jku@cs169rides.com"
  def invitation_notification(user)
    mail(:to => user.email, :subject => "You've been invited to join a trip.")
  end
end
