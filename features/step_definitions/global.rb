Given /^there exists a user with email "([^"]*)" and password "([^"]*)"$/ do |email, password|
  @person = create_valid!('Person',
    :email => email,
    :password => password,
    :password_confirmation => password
  )
end

Given /^I am signed in$/ do
  @person = create_valid!('Person', :email => 'myemail@email.com')
  visit '/signin'
  fill_in 'Email', :with => @person.email
  fill_in 'Password', :with => @person.password
  click_button('Sign in')
end

Then /^the "([^"]*)" radio button for "([^"]*)" should be selected$/ do |option, group|
  response.should have_selector("#person_#{group.downcase.gsub(' ', '_')}_#{option.downcase.gsub(' ', '_')}", :type => "radio", :checked => "checked")
end
