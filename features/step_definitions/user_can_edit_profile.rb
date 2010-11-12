Given /^I am signed in with password "([^"]*)"$/ do |password|
  Given %{I am signed in}
  @person.password = @person.password_confirmation = password
  @person.save!
end