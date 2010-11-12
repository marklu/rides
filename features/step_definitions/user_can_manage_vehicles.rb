Given /^I have added my "([^"]*)" passenger "([^"]*)" "([^"]*)"$/ do |capacity, make, model|
  @person.vehicles.create!(:make => make, :model => model, :capacity => capacity)
end