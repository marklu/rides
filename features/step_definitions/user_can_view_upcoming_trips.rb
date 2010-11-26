Given /^I am participating in the following trips:$/ do |trips|
  trips.hashes.each do |trip|
    trip = create_valid!('Trip',
      :name => trip['name'],
      :location => Location.create!(:location => trip['location']),
      :time => Time.parse(trip['time'])
    )
    trip.participants << @person
    trip.save!
  end
end

Then /^I should see "([^"]*)" (\w*)$/ do |text, order|
  orders = {'first' => 1, 'second' => 2, 'third' => 3, 'fourth' => 4, 'fifth' => 5}
  Then %{I should see "#{text}" within "#trips .section:nth-child(#{orders[order]})"}
end