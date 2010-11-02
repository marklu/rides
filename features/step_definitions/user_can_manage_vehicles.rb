Given /^I have added my "([^"]*)" passenger "([^"]*)" "([^"]*)"$/ do |capacity, make, model|
  visit path_to("the add vehicle page")
  fill_in('Make', :with => make)
  fill_in('Model', :with => model)
  fill_in('Capacity', :with => capacity)
  click_button('Create Vehicle')
end