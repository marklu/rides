Given /^I am assigned a ride arrangement$/ do
  @arrangement = create_valid!(Arrangement, :trip => @trip)
  @arrangement.passengers << @person
  @arrangement.save!
end

Given /^I am not assigned a ride arrangement$/ do
end

Given /^the following people are assigned to my ride arrangement:$/ do |participants|
  participants.hashes.each do |participant|
    @arrangement.passengers << Person.where(:name => participant['name']).first
  end
  @arrangement.save!
end

Given /^the following people are on the same ride arrangement:$/ do |passengers|
  arrangement = create_valid!(Arrangement, :trip => @trip)
  passengers.hashes.each do |passenger|
    arrangement.passengers << Person.where(:name => passenger['name']).first
  end
  arrangement.save!
end
