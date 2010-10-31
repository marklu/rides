Given /^I want to .*?$/ do
end

Given /^I am logged in as a user$/ do
  visit "/signout"
  visit "/signin"
  fill_in("Email", :with => "test@test.com")
  fill_in("Password", :with => "testpassword")
  click_button("Sign in")
end

Given /^(?:|I )have an account with email "([^"]*)" and password "([^"]*)"$/ do |email, password|
  visit "/signout"
  visit "/signup"
  fill_in("Email", :with => "test@test.com")
  fill_in("Password", :with => "testpassword")
  fill_in("Password confirmation", :with => "testpassword")
  fill_in("Name", :with => "Test Name")
  fill_in("Phone", :with => "123-Test-Phone")
  fill_in("Address", :with => "123 Test Street")
  fill_in("City", :with => "Testville")
  fill_in("State", :with => "CA")
  click_button("Sign up")
  visit "/signout"

Given /^I am not authenticated$/ do
  visit('/signout') # ensure that at least
end

Given /^I have one\s+person "([^\"]*)" with password "([^\"]*)"$/ do |email, password|
  Person.new(:email => email,
           :password => password,
           :password_confirmation => password).save!
end

Given /^I am a new, authenticated person$/ do
  email = 'test@test.com'
  password = 'testpassword'

  Given %{I have one person "#{email}" with password "#{password}""}
  And %{I go to the sign in page}
  And %{I fill in "person_email" with "#{email}"}
  And %{I fill in "person_password" with "#{password}"}
  And %{I press "Sign in"}
end

#Given /^There is a person named "([^"]*)"$/ do |name|
#  Person.create!(:name => name)
#end
