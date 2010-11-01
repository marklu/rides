Feature: Trip participant can view ride arrangement

  As a trip participant
  I want to view my ride arrangement
  So that I can participate in the trip

  Scenario: I can see who is on my ride arrangement
  Given there is a trip named "Company Picnic"
  And the following people are on the same ride arrangement for "Company Picnic":
    | name  | email             | password |
    | Joe   | joe@exmaple.com   | test     |
    | Alice | alice@example.com | test     |
    | Bob   | bob@example.com   | test     |
  When I sign in with email "joe@example.com" and password "test" 
  And I go to the trips dashboard
  Then I should see "Company Picnic"
  And I should see "Alice"
  And I should see "Bob"

  Scenario: I am notified if I am not in a ride arrangement
  Given there is a trip named "Company Picnic"
  And there following people do not have a ride arrangement for "Company Picnic":
    | name | email           | password |
    | Joe  | joe@example.com | test     |
  When I sign in with email "joe@example.com" and password "test"
  And I go to the trips dashboard
  Then I should see "Company Picnic"
  And I should see "You have no ride arrangement."
