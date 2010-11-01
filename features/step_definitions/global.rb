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

Given /^there is a person named "([^"]*)"$/ do |name|
  Person.create!(:name => name)
end

Given /^there is a person named "([^"]*)" with email "([^"]*)" and password "([^"]*)"$/ do |name, email, password|
  Person.create!(:name => name, :email => email, :password => password, :address => "123 Test Street", :city => "Testville", :state => "CA", :phone => "510-555-0199")
end

When /^I sign in with email "([^"]*)" and password "([^"]*)"$/ do |email, password|
  Given %{I am not authenticated}
  visit "/signin"
  fill_in "person[email]", :with => email
  fill_in "person[password]", :with => password
  click_button("Sign in")
end

Then /^the "([^"]*)" radio button should be selected$/ do |choice|
  #  input("##{choice}").should be_checked
  response_body.should have_selector "input[id=#{choice}][type=radio][checked=checked]"

end
