Feature: Trip organizer can view all ride arrangements

  As a trip organizer
  I want to view all ride arrangements
  So that I can verify the trip will proceed with no issues

  Scenario: Organizer sees every arrangement
    Given there is a trip named "Company Picnic"
    And the following people are on the same ride arrangement for "Company Picnic":
      | name  | email             | password |
      | Joe   | joe@exmaple.com   | Test123! |
      | Alice | alice@example.com | Test123! |
      | Bob   | bob@example.com   | Test123! |
    When I sign in with email "joe@example.com" and password "Test123!" 
    And I go to the trips dashboard
    Then I should see "Company Picnic"
    And I should see "Alice"
    And I should see "Bob"

  Scenario: Organizer sees details for each arrangement