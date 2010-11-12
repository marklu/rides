Feature: Trip participant can view ride arrangement

  So that I can go on the trip
  As a trip participant
  I want to view my ride arrangement

  Background: I am a participant in an upcoming trip having other participants
    Given I am signed in
    And there is an upcoming trip named "Company Picnic"
    And I am a participant
    And the following people are participants:
      | name  |
      | Alice |
      | Bob   |
      | Joe   |

  Scenario: I can see who is on my ride arrangement
    Given I am assigned a ride arrangement
    And the following people are assigned to my ride arrangement:
      | name  |
      | Alice |
      | Bob   |
      | Joe   |
    When I go to the dashboard page
    Then I should see "Company Picnic"
    And I should see "Alice"
    And I should see "Bob"
    And I should see "Joe"

  Scenario: I am notified if I am not in a ride arrangement
    Given I am not assigned a ride arrangement
    When I go to the dashboard page
    Then I should see "Company Picnic"
    And I should see "You have no ride arrangement."
