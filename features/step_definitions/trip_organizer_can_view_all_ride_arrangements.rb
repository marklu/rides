Given /^I am organizing an upcoming trip named "([^"]*)"$/ do |trip_name|
  Given %{there is an upcoming trip named "#{trip_name}"}
  @trip.organizer = @person
  @trip.save!
end

Given /^the following people are on the same ride arrangement:$/ do |passengers|
  arrangement = @trip.arrangements.create!
  passengers.hashes.each do |passenger|
    arrangement.passengers << Person.where(:name => passenger['name']).first
  end
  arrangement.save!
end

When /^I visit the all arrangements page for "([^"]*)"$/ do |trip_name|
  trip = Trip.where(:name => trip_name).first
  visit "/trips/#{trip.id}/arrangements"
end