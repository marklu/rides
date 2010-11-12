Feature: User can view upcoming trips

  So that I know my ride arrangement
  As a user
  I want to view my upcoming trips

  Background: I am a participant of many trips
    Given I am signed in
    Given I am participating in a trip named "Trip 1" at "123 Address", "City", "State" on "December 25, 2015 10:00"
    And I am participating in a trip named "Trip 2" at "123 Address", "City", "State" on "December 25, 2015 10:00"

  Scenario: I see a list of upcoming trips on my dashboard
    When I go to the dashboard page
    Then I should see "Trip 1"
    Then I should see "Trip 2"

  Scenario: I see the location and date for each trip
    When I go to the dashboard page
    Then I should see "123 Address"
    And I should see "City"
    And I should see "State"
    And I should see "2015-12-25"

  Scenario: I can view info for each trip
    When I go to the dashboard page
    And I follow "Trip 1"
    Then I should see "2015-12-25"
    And I should see "123 Address"
    And I should see "City"
    And I should see "State"
