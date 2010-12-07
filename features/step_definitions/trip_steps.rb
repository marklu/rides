Given /^there is an upcoming trip named "([^"]*)"$/ do |name|
  @trip = create_valid!(Trip, :name => name, :time => Time.now() + 86400)
end

Given /^I am organizing an upcoming trip named "([^"]*)"$/ do |trip_name|
  Given %{there is an upcoming trip named "#{trip_name}"}
  @trip.organizers << @person
  @trip.save!
end

Given /^(?:I am|"([^"]*)" is) a participant$/ do |name|
  person = name.nil? ? 
    @person :
    create_valid!(Person, :name => name, :email => "#{name.downcase}@email.com")
  @trip.participants << person
  @trip.save!
end

Given /^the following people are participants:$/ do |participants|
  participants.hashes.each do |participant|
    @trip.participants << create_valid!(Person,
      :name => participant['name'],
      :email => "#{participant['name'].downcase}@email.com"
    )
  end
  @trip.save!
end

Given /^I (?:am participating|participated) in the following trips:$/ do |trips|
  trips.hashes.each do |trip|
    trip = create_valid!(Trip,
      :name => trip['name'],
      :location => create_valid!(Location, :location => trip['location']),
      :time => Time.parse(trip['time'])
    )
    trip.participants << @person
    trip.save!
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
