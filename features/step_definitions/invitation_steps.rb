Given /^"([^"]*)" has already been invited to participate in the trip$/ do |name|
  create_valid!(Invitation,
    :invitee => name,
    :email => "#{name.downcase}@email.com",
    :role => 'participant',
    :trip => @trip
  )
  reset_mailer
end

Given /^I have been invited to participate with token "([^"]*)"$/ do |token|
  create_valid!(Invitation,
    :email => @person.nil? ? 'myemail@email.com' : @person.email,
    :role => 'participant',
    :token => token,
    :trip => @trip
  )
end

Then /^"([^"]*)" should be invited to participate in the trip$/ do |name|
  @trip.invitees.select {|invitee| invitee[:name] == name && invitee[:role] == 'participant'}.should_not be_empty
end

Then /^"([^"]*)" should be invited to organize the trip$/ do |name|
  @trip.invitees.select {|invitee| invitee[:name] == name&& invitee[:role] == 'organizer'}.should_not be_empty
end