Feature: User can view upcoming trips

  So that I know my ride arrangement
  As a user
  I want to view my upcoming trips

  Background: I am a participant of many trips
    Given I am signed in
    Given I am participating in the following trips:
      | name   | location                                     | time                    |
      | Trip 1 | 1 Infinite Loop, Cupertino, CA               | December 25, 2013 10:00 |
      | Trip 2 | 1600 Amphitheatre Parkway, Mountain View, CA | December 25, 2012 10:00 |

  Scenario: I see a list of upcoming trips on my dashboard
    When I go to the dashboard page
    Then I should see "Trip 2" first
    And I should see "Trip 1" second

  Scenario: I see the location and date for each trip
    When I go to the dashboard page
    Then I should see "1 Infinite Loop, Cupertino, CA"
    And I should see "December 25, 2013"

  Scenario: I can view info for each trip
    When I go to the dashboard page
    And I follow "Trip 1"
    Then I should see "December 25, 2013"
    And I should see "1 Infinite Loop, Cupertino, CA"