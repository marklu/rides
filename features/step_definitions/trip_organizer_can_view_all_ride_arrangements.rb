When /^I visit the all arrangements page for "([^"]*)"$/ do |trip_name|
  trip = Trip.where(:name => trip_name).first
  visit "/trips/#{trip.id}/arrangements"
end