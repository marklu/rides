Given /^I have added my "([^"]*)" passenger "([^"]*)" "([^"]*)"$/ do |capacity, make, model|
  @person.vehicles.create!(:make => make, :model => model, :capacity => capacity)
end

Given /^the following people have the following cars:$/ do |cars|
  cars.hashes.each do |car|
    person = Person.where(:name => car['owner']).first
    vehicle = Vehicle.create!(:owner => person, :make => car['make'], :model => car['model'], :capacity => 5)
  end
end
