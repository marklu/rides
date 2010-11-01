Given /^there is a trip named "([^"]*)"$/ do |name|
  Trip.create!(:name => name)
end

Given /^the following people are on the same ride arrangement for "([^"]*)":$/ do |trip_name, participants|
  trip = Trip.where(:name => trip_name).first
  arrangement = trip.arrangements.create!
  participants.hashes.each do |participant|
    Given %{there is a person named "#{participant['name']}" with email "#{participant['email']}" and password "#{participant['password']}"}
    person = Person.where(:email => participant['email'])
    arrangement.passengers << person
  end
end

Given /^the following people do not have a ride arrangement for "([^"]*)":$/ do |arg1, table|
  # table is a Cucumber::Ast::Table
  pending # express the regexp above with the code you wish you had
end
