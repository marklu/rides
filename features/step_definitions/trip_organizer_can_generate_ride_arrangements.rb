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
