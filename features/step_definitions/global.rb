Given /^I want to .*?$/ do
end

Given /^I am logged in as a user$/ do
  visit "/signout"
  visit "/signin"
  fill_in("person[email]", :with => "test@test.com")
  fill_in("person[password]", :with => "testpassword")
  click_button("Sign in")

end