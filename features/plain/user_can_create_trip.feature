Feature: User can create trip

  So that I can organize transportation for my trip
  As a user
  I want to plan a new trip

  Background: I am signed in
    Given I am signed in

  Scenario: I can view the plan trip page
    When I go to the dashboard page
    And I follow "New Trip"
    Then I should be on the plan trip page

  Scenario: I can plan a trip
    When I go to the plan trip page
    Then I should see "Name"
    And I should see "Time"
    And I should see "Address"

  Scenario Outline: I plan a new trip
    Given I am on the plan trip page
    When I fill in "Name" with "<name>"
    And I select "<datetime>" as the date and time
    And I fill in "Address" with "<address>"
    And I press "Create Trip"
    Then I should see "<result>"

    Scenarios: with valid information
      | name      | datetime                | address                                      | result                        |
      | Trip Name | December 25, 2010 10:00 | 1600 Amphitheatre Parkway, Mountain View, CA | Trip was successfully created |

    Scenarios: with invalid information
      | name      | datetime                | address                                      | result                                 |
      |           | December 25, 2010 10:00 | 1600 Amphitheatre Parkway, Mountain View, CA | Name can't be blank                    |
#     | Trip Name | December 25, 2010 10:00 |                                              | Address must be a valid street address |
#     | Trip Name | December 25, 2010 10:00 | Amphitheatre Parkway, Mountain View, CA      | Address must be a valid street address |
#     | Trip Name | December 25, 2010 10:00 | 123 Address                                  | Address must be a valid street address |
#     | Trip Name | December 25, 2010 10:00 | String                                       | Address must be a valid street address |
