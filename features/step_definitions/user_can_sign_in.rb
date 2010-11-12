Given /^I am signed up with email "([^"]*)" and password "([^"]*)"$/ do |email, password|
  create_valid!('Person',
    :email => email,
    :password => password,
    :password_confirmation => password
  )
end