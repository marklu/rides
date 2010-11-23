# Selenium, used to trigger autocomplete dropdowns
When /^I type "([^"]*)" into "([^"]*)"$/ do |value, field|
  locator = "webrat=#{field}"
  selenium.wait_for_element locator, :timeout_in_seconds => 30
  selenium.type locator, ''
  sleep 0.1
  selenium.type locator, value
  sleep 0.1
  selenium.type_keys locator, "  "
  sleep 0.1
end

# Selenium, used to select an element of an autocomplete dropdown
When /^I select "([^"]*)"$/ do |value|
  locator = "webratlink=#{value}"
  selenium.wait_for_element locator, :timeout_in_seconds => 30
  selenium.mouse_over locator
  sleep 0.1
  selenium.click locator
  sleep 0.1
end

# Selenium, asserts that some form field contains the given value
Then /^"([^"]*)" should contain "([^"]*)"$/ do |field, value|
  locator = "webrat=#{field}"
  selenium.wait_for_element locator, :timeout_in_seconds => 30
  selenium.get_value(locator).should == value
end
