Given /^there is a trip named "([^"]*)"$/ do |name|
  Given %{there is a person named "Test Organizer" with email "testorganizer@example.com" and password "Test123!"}
  organizer = Person.where(:email => "testorganizer@example.com").first
  Trip.create!(:name => name, :organizer => organizer, :time => Time.now() + 86400, :address => "123 Main St", :city => "Testville", :state => "CA")
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

Given /^the following people do not have a ride arrangement for "([^"]*)":$/ do |trip_name, participants|
  trip = Trip.where(:name => trip_name).first
  participants.hashes.each do |participant|
    person = Person.where(:email => participant['email']).first
    if !person.nil?
      trip.arrangements.each do |arrangement|
        arrangement.participants.delete person
      end
    end
  end
end
