Given /^I have a trip called "([^"]*)" at address "([^"]*)" in city "([^"]*)" in state "([^"]*)" on "([^"]*)"$/ do |name, address, city, state, datetime|

  
  visit '/trips/new'
  fill_in("trip[name]", :with => name)
  fill_in("trip[address]", :with => address)
  fill_in("trip[city]", :with => city)
  fill_in("trip[state]", :with => state)
  select_datetime(datetime)
  click_button("Create Trip")

end
