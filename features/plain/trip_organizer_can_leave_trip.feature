Feature: Trip organizer can leave trip

  So that I will no longer be assigned to any ride arrangements
  As a trip organizer and participant
  I want to be able to leave a trip

  Background: I am an organizer and participant in an upcoming trip
    Given I am signed in
    And I am organizing an upcoming trip named "Company Picnic"
    And I am a participant

  Scenario: I leave the trip
    Given I am on the manage membership page
    When I press "Leave Trip"
    Then I should be on the trip info page
    And I should see "You are no longer participating in Company Picnic"
