Given /^there is a trip named "([^"]*)"$/ do |name|
  Trip.create!(:name => name)
end

Given /^I am in a ride arrangement for "([^"]*)"$/ do |trip_name|
  trip = Trip.where(:name => trip_name)
  arrangement = trip.arrangements.create!()
  arrangement << current_user
end

Given /^"([^"]*)" is in my ride arrangement for "([^"]*)"$/ do |person_name, trip_name|
  Given %{there is a person named "#{person_name}"}
  arrangement = Trip.where(:name => trip_name).arrangements.find(:first, :include => current_user)
  person = People.where(:name => person_name)
  arrangement << person
end

