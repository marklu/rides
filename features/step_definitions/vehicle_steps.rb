Given /^I have added my "([^"]*)" passenger "([^"]*)" "([^"]*)"$/ do |capacity, make, model|
  @vehicle = create_valid!(Vehicle,
    :make => make,
    :model => model,
    :capacity => capacity,
    :owner => @person
  )
end

Given /^the following people have the following cars:$/ do |cars|
  cars.hashes.each do |car|
    person = Person.where(:name => car['owner']).first
    vehicle = Vehicle.create!(:owner => person, :make => car['make'], :model => car['model'], :capacity => 5)
  end
end
