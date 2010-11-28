
require 'digest/md5'


Given /^there is an invitation to "([^"]*)" sent to "([^"]*)" with token "([^"]*)"$/ do |tripname, email, token|
  @trip = create_valid!('Trip',
    :name => tripname,
    :time => Time.now + 1000000)
  @invitation = create_valid!('Invitation',
    :pending_trip => @trip,
    :email => email,
    :token => token
  )
  @trip.invitations << @invitation
  @trip.save!
end

Given /^I'm on the manage trip page with token "([^"]*)"$/ do |token|
  url = "#{manage_trip_path(@trip)}?token=#{token}"
  visit(url)
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

