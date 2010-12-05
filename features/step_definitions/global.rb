# Authentication
Given /^I am signed up$/ do
  @person = create_valid!('Person', :email => 'myemail@email.com')
end

Given /^I am signed in$/ do
  Given %{I am signed up}
  visit '/signin'
  fill_in 'Email', :with => @person.email
  fill_in 'Password', :with => @person.password
  click_button('Sign in')
end

Given /^I am signed in with password "([^"]*)"$/ do |password|
  Given %{I am signed in}
  @person.password = @person.password_confirmation = password
  @person.save!
end

Given /^I am signed up with email "([^"]*)" and password "([^"]*)"$/ do |email, password|
  create_valid!('Person',
    :email => email,
    :password => password,
    :password_confirmation => password
  )
end

When /^I sign in$/ do
  visit '/signin'
  fill_in 'Email', :with => @person.email
  fill_in 'Password', :with => @person.password
  click_button('Sign in')
end

# Application State
Given /^"([^"]*)" has signed up$/ do |name|
  create_valid!('Person', :name => name, :email => "#{name.downcase}@email.com")
end

Given /^there is an upcoming trip named "([^"]*)"$/ do |name|
  @trip = create_valid!('Trip', :name => name, :time => Time.now() + 86400)
end

Given /^I am organizing an upcoming trip named "([^"]*)"$/ do |trip_name|
  Given %{there is an upcoming trip named "#{trip_name}"}
  @trip.organizer = @person
  @trip.save!
end

Given /^I am a participant$/ do
  @trip.participants << @person
  @trip.save!
end

Given /^the following people are participants:$/ do |participants|
  participants.hashes.each do |participant|
    @trip.participants << create_valid!('Person',
      :name => participant['name'],
      :email => "#{participant['name'].downcase}@email.com"
    )
  end
  @trip.save!
end

Given /^I am participating in the following trips:$/ do |trips|
  trips.hashes.each do |trip|
    trip = create_valid!('Trip',
      :name => trip['name'],
      :location => Location.create!(:location => trip['location']),
      :time => Time.parse(trip['time'])
    )
    trip.participants << @person
    trip.save!
  end
end

Given /^I participated in the following trips:$/ do |trips|
  Given %{I am participating in the following trips:}, trips
end

# Potential user can sign up
Then /^the "([^"]*)" radio button for "([^"]*)" should be selected$/ do |option, group|
  response.should have_selector("#person_preferences_attributes_#{group.downcase.gsub(' ', '_')}_#{option.downcase.gsub(' ', '_')}", :type => "radio", :checked => "checked")
end

# Trip organizer can generate ride arrangements
Given /^the following people have the following cars:$/ do |cars|
  cars.hashes.each do |car|
    person = Person.where(:name => car['owner']).first
    vehicle = Vehicle.create!(:owner => person, :make => car['make'], :model => car['model'], :capacity => 5)
  end
end

Given /^the following people are driving:$/ do |drivers|
  drivers.hashes.each do |driver|
    person = Person.where(:name => driver['name']).first
    vehicle = person.vehicles.first
    @trip.vehicles << vehicle
    @trip.save!
  end
end

# Trip organizer can view all ride arrangements
Given /^the following people are on the same ride arrangement:$/ do |passengers|
  arrangement = @trip.arrangements.create!
  passengers.hashes.each do |passenger|
    arrangement.passengers << Person.where(:name => passenger['name']).first
  end
  arrangement.save!
end

# Trip participant can view ride arrangement
Given /^I am assigned a ride arrangement$/ do
  @arrangement = @trip.arrangements.create!(
    :driver => create_valid!('Person', :email => 'driver@email.com'),
    :vehicle => create_valid!('Vehicle')
  )
  @arrangement.passengers << @person
end

Given /^the following people are assigned to my ride arrangement:$/ do |participants|
  participants.hashes.each do |participant|
    @arrangement.passengers << Person.where(:name => participant['name']).first
  end
  @arrangement.save!
end

Given /^I am not assigned a ride arrangement$/ do
end

# User can manage vehicles
Given /^I have added my "([^"]*)" passenger "([^"]*)" "([^"]*)"$/ do |capacity, make, model|
  @person.vehicles.create!(:make => make, :model => model, :capacity => capacity)
end

# User can view upcoming trips
Then /^I should see "([^"]*)" (\w*)$/ do |text, order|
  orders = {'first' => 1, 'second' => 2, 'third' => 3, 'fourth' => 4, 'fifth' => 5}
  Then %{I should see "#{text}" within "#trips .section:nth-child(#{orders[order]})"}
end

# Trip organizer can invite people to join trip
Then /^"([^"]*)" should be invited to participate in the trip$/ do |name|
  @trip.invitees.should include("#{name.downcase}@email.com")
end

Given /^"([^"]*)" has already been invited to participate in the trip$/ do |name|
  @trip.invitations.create!(:email => "#{name.downcase}@email.com", :token => "token")
  reset_mailer
end

Given /^"([^"]*)" is a participant$/ do |name|
  @trip.participants << create_valid!('Person',
    :name => name,
    :email => "#{name.downcase}@email.com"
  )
end

# User can join trip
Given /^I have been invited to participate with token "([^"]*)"$/ do |token|
  @trip.invitations.create!(
    :email => @person.nil? ? 'myemail@email.com' : @person.email,
    :token => token
  )
end