Feature: Trip organizer can manage trip membership

  So that I may update my role in the trip
  As a trip organizer
  I want to manage my trip membership

  Background: I am organizing an upcoming trip
    Given I am signed in
    And I am organizing an upcoming trip named "Company Picnic"

  Scenario: I can manage my trip membership
    When I go to the trip info page
    And I follow "Manage Membership"
    Then I should be on the manage membership page

  Scenario: I join the trip
    When I go to the manage membership page
    And I press "Join Trip"
    Then I should see "You are now a participant in the Company Picnic"