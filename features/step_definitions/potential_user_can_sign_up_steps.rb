Then /^the "([^"]*)" radio button for "([^"]*)" should be selected$/ do |option, group|
  response.should have_selector("#person_preferences_attributes_#{group.downcase.gsub(' ', '_')}_#{option.downcase.gsub(' ', '_')}", :type => "radio", :checked => "checked")
end
