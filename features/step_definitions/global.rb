Given /^I want to .*?$/ do
end

Given /^I am logged in as a user$/ do
  visit "/signout"
  visit "/signin"
  fill_in("person[email]", :with => "test@test.com")
  fill_in("person[password]", :with => "testpassword")
  click_button("Sign in")

end

Given /^I am not authenticated$/ do
  visit('/signout') # ensure that at least
end


Given /^(?:|I )have an account with email "([^"]*)" and password "([^"]*)"$/ do |email, password|
  visit "/signout"
  visit "/signup"
  fill_in("person[email]", :with => "test@test.com")
  fill_in("person[password]", :with => "testpassword")
  fill_in("person[password_confirmation]", :with => "testpassword")
  fill_in("person[name]", :with => "Test Name")
  fill_in("person[phone]", :with => "123-Test-Phone")
  fill_in("person[address]", :with => "123 Test Street")
  fill_in("person[city]", :with => "Testville")
  fill_in("person[state]", :with => "CA")
  click_button("Sign up")
  visit "/signout"

end

Given /^There is a person named "([^"]*)"$/ do |name|
  Person.create!(:name => name)
end
