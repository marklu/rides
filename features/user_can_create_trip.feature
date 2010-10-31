Feature: User can create trip

  As a user
  I want to create a new trip
  So that I can organize transportation for the participants

  Scenario: User can view the create trip page
    Given I have an account with email "test@test.com" and password "testpassword"
    And I want to create a trip
    And I am logged in as a user
    When I go to the dashboard page
    And I follow "Create trip"
    Then I should be on the create trip page

  Scenario: User can create a new trip
    Given I have an account with email "test@test.com" and password "testpassword"
    And I want to create a trip
    And I am logged in as a user
    When I go to the create trip page
    Then I should see "Time"
    Then I should see "Address"
    Then I should see "City"
    Then I should see "State"

  Scenario Outline: User creates trip
    Given I have an account with email "test@test.com" and password "testpassword"
    And I am logged in as a user
    And I am on the create trip page
    When I fill in "Time" with "<time>"
    And I fill in "Address" with "<address>"
    And I fill in "City" with "<city>"
    And I fill in "State" with "<state>"
    And I follow "Create trip"
    Then I should see "<result>"
	
    Scenarios: with valid information
      | time  | address         | city      | state      | result       |
      | 0:01  | 1 Infinite Loop | Cupertino | CA         | Trip created |
      | 0:01  | 1 Infinite Loop | Cupertino | California | Trip created |
      | 00:01 | 1 Infinite Loop | Cupertino | CA         | Trip created |
      | 12:00 | 1 Infinite Loop | Cupertino | CA         | Trip created |
      | 23:59 | 1 Infinite Loop | Cupertino | CA         | Trip created |

    Scenarios: with invalid information
      | time  | address         | city      | state | result |
      |       | 1 Infinite Loop | Cupertino | CA    | Error  |
      | 10:00 |                 | Cupertino | CA    | Error  |
      | 10:00 | 1 Infinite Loop |           | CA    | Error  |
      | 10:00 | 1 Infinite Loop | Cupertino |       | Error  |