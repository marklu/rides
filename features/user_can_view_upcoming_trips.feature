Feature: User can view upcoming trips

  As a user
  I want to view my upcoming trips
  So that I am aware of my ride assignment

  Scenario: User sees list of upcoming trips on dashboard
    Given I want to see a list of my upcoming trips
    And I have an account with email "test@test.com" and password "testpassword"
    And I am logged in as a user
    And I have a trip called "Epic Trip" at address "1 Infinite Dr." in city "Berkeley" in state "CA" on "December 25, 2015 10:00"
    And I have a trip called "Boring Trip" at address "2 Infinite Dr." in city "Berkeley" in state "CA" on "December 26, 2015 10:00"
    When I go to the dashboard page
    Then I should see "Epic Trip"
    Then I should see "Boring Trip"

  Scenario: User sees location and date for each trip
    Given I want to see location and date for each trip
    And I have an account with email "test@test.com" and password "testpassword"
    And I am logged in as a user
    And I have a trip called "Epic Trip" at address "1 Infinite Dr." in city "Berkeley" in state "CA" on "December 25, 2015 10:00"
    When I go to the dashboard page
    Then I should see "1 Infinite Dr."
    And I should see "Berkeley"
    And I should see "CA"
    And I should see "2015-12-25"


  Scenario: User can view trip info for each trip
    Given I want to see trip info for a given trip
    And I have an account with email "test@test.com" and password "testpassword"
    And I am logged in as a user
    And I have a trip called "Epic Trip" at address "1 Infinite Dr." in city "Berkeley" in state "CA" on "December 25, 2015 10:00"
    When I go to the dashboard page
    And I follow "Epic Trip"
    Then I should see "Time: 2015-12-25 10:00:00"
    And I should see "Address: 1 Infinite Dr."
    And I should see "City: Berkeley"
    And I should see "State: CA"