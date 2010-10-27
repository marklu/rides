Feature: User can view upcoming trips

  As a user
  I want to view my upcoming trips
  So that I am aware of my ride assignment

  Scenario: User sees list of upcoming trips on dashboard
    Given I want to see a list of my upcoming trips
    And I am logged in as a user
    When I go to the dashboard page
    Then I should see my trips

  Scenario: User sees location and date for each trip
    Given I want to see location and date for each trip
    And I am logged in as a user
    When I go to the dashboard page
    Then I should see "Location"
    And I should see "Date"

  Scenario: User can view trip info for each trip
    Given I want to see trip info for a given trip
    And I am logged in as a user
    When I go to the dashboard page
    And I follow "Trip Info"
    Then I should see "Time"
    And I should see "Address"
    And I should see "City"
    And I should see "State"