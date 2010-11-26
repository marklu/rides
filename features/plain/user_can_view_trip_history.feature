Feature: User can view trip history

  So that I can know which trips I have participated in
  As a user
  I want to view my trip history

  Background: I participated and am participating in many trips
    Given I am signed in
    And I am participating in the following trips:
      | name            | location                              | time                   |
      | Upcoming Trip 1 | 795 Folsom Street, San Francisco, CA  | January 5, 2012 10:00  |
      | Upcoming Trip 2 | 1475 Folsom Street, San Francisco, CA | February 5, 2012 10:00 |
    And I participated in the following trips:
      | name          | location                                            | time                   |
      | Passed Trip 1 | 1601 South California Avenue, Palo Alto, California | January 5, 2009 10:00  |
      | Passed Trip 2 | 329 East Jimmie Leeds Road, Absecon, NJ             | February 5, 2009 10:00 |

  Scenario: I can view the trip history page
    When I go to the dashboard page
    And I follow "Trip History"
    Then I should be on the trip history page

  Scenario: I can view list of all past and upcomming trips
    When I go to the trip history page
    Then I should see "Upcoming Trip 1"
    And I should see "Upcoming Trip 2"
    And I should see "Passed Trip 1"
    And I should see "Passed Trip 2"

  Scenario: I see the location and date for each trip
    When I go to the trip history page
    Then I should see "Upcoming Trip 1"
    And I should see "795 Folsom Street, San Francisco, CA"
    And I should see "2012-01-05"

  Scenario: I can view info for each trip
    When I go to the trip history page
    And I follow "Upcoming Trip 1"
    Then I should see "Upcoming Trip 1"
    And I should see "795 Folsom Street, San Francisco, CA"
    And I should see "2012-01-05"

  Scenario: I can filter by month
    When I go to the trip history page
    Then I should see "February 2012"
    And I should see "January 2012"
    And I should see "February 2009"
    And I should see "January 2009"

  Scenario: I filter by month
    When I go to the trip history page
    And I follow "January 2012"
    Then I should see "Upcoming Trip 1"
    But I should not see "Upcoming Trip 2"
    And I should not see "Passed Trip 1"
    And I should not see "Passed Trip 2"