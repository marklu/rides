# Given I am signed up
# Given I am signed up with email "email@email.com"
# Given I am signed up with password "password"
# Given I am signed up with email "email@email.com" and with password "password"
# Given "Name" is signed up
# Given "Name" is signed up with email "name@email.com"
# Given "Name" is signed up with password "password"
# Given "Name" is signed up with email "email@email.com" and with password "password"
Given /^(?:I am|"([^"]*?)" is) signed up(?: with email "([^"]*)")?(?:(?: and)? with password "([^"]*)")?$/ do |name, email, password|
  @person = build_valid(Person)
  @person.email = !email.nil? ? email :
                  !name.nil? ? "#{name.downcase}@email.com" :
                  'myemail@email.com'
  @person.password = !password.nil? ? password :
                     @person.password
  @person.save
end

# Given I am signed in
# Given I am signed in with email "email@email.com"
# Given I am signed in with password "password"
# Given I am signed in with email "email@email.com" and with password "password"
Given /^I am signed in(?: with email "([^"]*)")?(?:(?: and)? with password "([^"]*)")?$/ do |email, password|
  @person = build_valid(Person)
  @person.email = !email.nil? ? email : 'myemail@email.com'
  @person.password = !password.nil? ? password : @person.password
  @person.save

  visit '/signin'
  fill_in 'Email', :with => @person.email
  fill_in 'Password', :with => @person.password
  click_button('Sign in')
end

When /^I sign in$/ do
  visit '/signin'
  fill_in 'Email', :with => @person.email
  fill_in 'Password', :with => @person.password
  click_button('Sign in')
end
