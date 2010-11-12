Given /^I am participating in a trip named "([^"]*)" at "([^"]*)", "([^"]*)", "([^"]*)" on "([^"]*)"$/ do |name, address, city, state, time|
  trip = create_valid!('Trip',
    :name => name,
    :address => address,
    :city => city,
    :state => state,
    :time => Time.parse(time)
  )
  trip.participants << @person
  trip.save!
end
