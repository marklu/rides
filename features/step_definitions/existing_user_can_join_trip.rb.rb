Given /^user with email "([^"]*)" has an invitation to future trip called "([^"]*)"$/ do |email, tripname|
  @organizer = Person.find(:first, :conditions => [ "email = ?", email ])
  @trip = create_valid!('Trip',
    :name => tripname,
    :time => Time.now + 1000000,
    :organizer => @organizer)
  
  @invitee = Person.find(:first, :conditions => [ "email = ?", email ])

  @invitee.pending_trips << @trip
end


Then /^I should be a participant in "([^"]*)"$/ do |tripname|
  #  @new_participant = Person.find(:first, :conditions => [ "email = ?", email ])
  @trip = Trip.find(:first, :conditions => [ "name = ?", tripname ])

  @trip.participants.should include(@person)
  @person.trips.should include(@trip)
end

Then /^I should not have an invitation to "([^"]*)"$/ do |tripname|
  #  @new_participant = Person.find(:first, :conditions => [ "email = ?", email ])
  @trip = Trip.find(:first, :conditions => [ "name = ?", tripname ])

  @person.pending_trips.should_not include(@trip)
  @trip.invitees.should_not include(@person)
end
