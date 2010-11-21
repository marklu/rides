Given /^I am participating in the following trips:$/ do |trips|
  trips.hashes.each do |trip|
    trip = create_valid!('Trip',
      :name => trip['name'],
      :address => trip['address'],
      :time => Time.parse(trip['time'])
    )
    trip.participants << @person
    trip.save!
  end
end