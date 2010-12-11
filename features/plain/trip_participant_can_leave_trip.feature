Feature: Trip participant can leave trip

  So that I will no longer be assigned to any ride arrangements
  As a trip participant
  I want to be able to leave a trip

  Background: I am a participant in an upcoming trip
    Given I am signed in
    And there is an upcoming trip named "Company Picnic"
    And I am a participant

  Scenario: I leave the trip
    Given I am on the manage membership page
    When I press "Leave Trip"
    Then I should be on the dashboard page
    And I should see "You are no longer participating in Company Picnic"

  Scenario: After I leave the trip, I do not see it on my dashboard
    Given I am on the manage membership page
    When I press "Leave Trip"
    And I go to the dashboard page
    Then I should not see "Company Picnic"