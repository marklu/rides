Feature: Trip participant can view ride arrangement

  As a trip participant
  I want to view my ride arrangement
  So that I can participate in the trip

  Scenario: I can see who is on my ride arrangement
  Given I am logged in as a user
  And there is a trip named "Company Picnic"
  And I am in a ride arrangement for "Company Picnic"
  And "Alice" is in my ride arrangement for "Company Picnic"
  And "Bob" is in my ride arrangement for "Company Picnic"
  When I go to the trips dashboard
  Then I should see "Alice"
  And I should see "Bob"
