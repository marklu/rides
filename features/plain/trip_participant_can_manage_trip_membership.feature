Feature: Trip participant can manage trip membership

  So that I may update my role in the trip
  As a trip participant
  I want to manage my trip membership

  Background: I am a participant in an upcoming trip
    Given I am signed in
    And there is an upcoming trip named "Company Picnic"
    And I am a participant

  Scenario: I can manage my trip membership
    When I go to the trip info page
    And I follow "Manage Membership"
    Then I should be on the manage membership page

  Scenario: I add a vehicle to my profile
    When I go to the manage membership page
    And I follow "Add Vehicle"
    When I fill in "Make" with "Toyota"
    And I fill in "Model" with "Camry"
    And I fill in "Capacity" with "4"
    And I press "Create Vehicle"
    Then I should be on the manage membership page
    And I should see "Vehicle was successfully added"

  Scenario: I already have a vehicle in my profile, but haven't opted in to drive
    Given I have added my "4" passenger "Toyota" "Camry"
    When I go to the manage membership page
    Then I should see "You are currently not a driver for this trip."

  Scenario: I volunteer to drive for the trip
    Given I have added my "4" passenger "Toyota" "Camry"
    When I go to the manage membership page
    And I choose "Toyota Camry with capacity 4"
    And I press "Drive"
    Then I should see "You are now a driver for the Company Picnic"
    And I go to the manage membership page
    And vehicle with ID "1" should be selected