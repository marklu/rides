Feature: Trip organizer can view all ride arrangements

  As a trip organizer
  I want to view all ride arrangements
  So that I can verify the trip will proceed with no issues

  Scenario: Organizer sees every arrangement
    Given there is an upcoming trip named "Company Picnic"
    And the following people are on the same ride arrangement for "Company Picnic":
      | name   | email              | password |
      | Allan  | allan@exmaple.com  | Test123! |
      | Alyssa | alyssa@example.com | Test123! |
      | Alex   | alex@example.com   | Test123! |
    And the following people are on the same ride arrangement for "Company Picnic":
      | name   | email              | password |
      | Baron  | Baron@exmaple.com  | Test123! |
      | Bailey | Bailey@example.com | Test123! |
      | Bob    | bob@example.com    | Test123! |
    And the following people are on the same ride arrangement for "Company Picnic":
      | name   | email              | password |
      | Cassie | cassie@exmaple.com | Test123! |
      | Caleb  | caleb@example.com  | Test123! |
      | Chase  | chase@example.com  | Test123! |
    When I sign in with email "testorganizer@example.com" and password "Test123!" 
    And I visit the all arrangements page for "Company Picnic"
    And I should see "Allan"
    And I should see "Baron"
    And I should see "Cassie"

  Scenario: Organizer sees details for each arrangement