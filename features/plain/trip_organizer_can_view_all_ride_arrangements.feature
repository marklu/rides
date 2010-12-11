Feature: Trip organizer can view all ride arrangements

  So that I can verify the trip will proceed without issue
  As a trip organizer
  I want to view all ride arrangements

  Background: I am the organizer in an upcoming trip having other participants
    Given I am signed in
    And I am organizing an upcoming trip named "Company Picnic"
    And the following people are participants:
      | name   |
      | Allan  |
      | Alyssa |
      | Alex   |
      | Baron  |
      | Bailey |
      | Bob    |
      | Cassie |
      | Caleb  |
      | Chase  |

  Scenario: I can view the arrangements page

  Scenario: I see every arrangement
    Given the following people are on the same ride arrangement:
      | name   |
      | Allan  |
      | Alyssa |
      | Alex   |
    And the following people are on the same ride arrangement:
      | name   |
      | Baron  |
      | Bailey |
      | Bob    |
    And the following people are on the same ride arrangement:
      | name   |
      | Cassie |
      | Caleb  |
      | Chase  |
    When I go to the arrangements page
    Then I should see "Allan"
    And I should see "Baron"
    And I should see "Cassie"

  Scenario: I see details for each arrangement