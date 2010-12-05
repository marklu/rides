Given /^"([^"]*)" has already been invited to participate in the trip$/ do |name|
  @trip.invitations.create!(:email => "#{name.downcase}@email.com", :token => "token")
  reset_mailer
end

Given /^I have been invited to participate with token "([^"]*)"$/ do |token|
  @trip.invitations.create!(
    :email => @person.nil? ? 'myemail@email.com' : @person.email,
    :token => token
  )
end

Then /^"([^"]*)" should be invited to participate in the trip$/ do |name|
  @trip.invitees.select {|invitee| invitee[:email] == "#{name.downcase}@email.com"}.should_not be_empty
end