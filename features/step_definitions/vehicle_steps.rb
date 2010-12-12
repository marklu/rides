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

Then /^vehicle with ID "([^"]*)" should be selected$/ do |id|
#  input("#vehicle_#{id}").should be_checked
  response.should have_selector("#vehicle_#{id}", :type => "radio", :checked => "checked")
end
