Then /^I should see "([^"]*)" (\w*)$/ do |text, order|
  orders = {'first' => 1, 'second' => 2, 'third' => 3, 'fourth' => 4, 'fifth' => 5}
  Then %{I should see "#{text}" within "#trips .section:nth-child(#{orders[order]})"}
end
