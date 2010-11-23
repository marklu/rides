Given /^there is an upcoming trip named "([^"]*)"$/ do |name|
  @trip = create_valid!('Trip', :name => name, :time => Time.now() + 86400)
end

Given /^I am a participant$/ do
  @trip.participants << @person
  @trip.save!
end

Given /^the following people are participants:$/ do |participants|
  participants.hashes.each do |participant|
    @trip.participants << create_valid!('Person',
      :name => participant['name'],
      :email => "#{participant['name']}@email.com"
    )
  end
  @trip.save!
end

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