Feature: Trip organizer can view trip participants

  So that I know who else is participating in the trip
  As a trip organizer
  I want to view a list of trip participants

  Background: I am the organizer in an upcoming trip having other participants
    Given I am signed in
    And I am organizing an upcoming trip named "Company Picnic"
    And the following people are participants:
      | name   |
      | Allan  |
      | Baron  |
      | Chase  |

  Scenario: I can view the trip participants page
    Given I am on the trip info page
    When I follow "Participants"
    Then I should be on the trip participants page

  Scenario: I see a lis of trip participants
    When I go to the trip participants page
    Then I should see "Allan"
    And I should see "Baron"
    And I should see "Chase"