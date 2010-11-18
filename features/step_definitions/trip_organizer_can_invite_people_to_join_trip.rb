Given /^there exists a user with email "([^"]*)" and password "([^"]*)"$/ do |email, password|
  @person = create_valid!('Person',
    :email => email,
    :password => password,
    :password_confirmation => password
  )
end

Given /^user with email "([^"]*)" is organizing a future trip called "([^"]*)"$/ do |email, tripname|
   @organizer = Person.find(:first, :conditions => [ "email = ?", email ])
   @trip = create_valid!('Trip',
    :name => tripname,
    :time => Time.now + 1000000,
    :organizer => @organizer)
end


When /^I fill in the "([^"]*)" field with "([^"]*)"$/ do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

Then /^the user with email "([^"]*)" should have an invitation to "([^"]*)"$/ do |email, tripname|
  @invitee = Person.find(:first, :conditions => [ "email = ?", email ])
  @trip = Trip.find(:first, :conditions => [ "name = ?", tripname ])

  @invitee.pending_trips.should include(@trip)
  @trip.invitees.should include(@invitee)

end

Given /^I'm signed in as "([^"]*)" and password "([^"]*)"$/ do |email, pwd|
  visit '/signin'
  fill_in 'Email', :with => email
  fill_in 'Password', :with => pwd
  click_button('Sign in')
end

Given /^the user with email "([^"]*)" has an invitation to "([^"]*)"$/ do |email, tripname|
  @invitee = Person.find(:first, :conditions => [ "email = ?", email ])
  @trip = Trip.find(:first, :conditions => [ "name = ?", tripname ])

  @invitee.pending_trips << @trip
end

Then /^the user with email "([^"]*)" should be a participant in "([^"]*)"$/ do |email, tripname|
  @new_participant = Person.find(:first, :conditions => [ "email = ?", email ])
  @trip = Trip.find(:first, :conditions => [ "name = ?", tripname ])

  @trip.participants.should include(@new_participant)
  @new_participant.trips.should include(@trip)
end

Then /^the user with email "([^"]*)" should not have an invitation to "([^"]*)"$/ do |email, tripname|
  @new_participant = Person.find(:first, :conditions => [ "email = ?", email ])
  @trip = Trip.find(:first, :conditions => [ "name = ?", tripname ])

  @new_participant.pending_trips.should_not include(@trip)
  @trip.invitees.should_not include(@new_participant)
end
