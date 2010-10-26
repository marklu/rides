Feature: User can manage vehicles

  As a user
  I want to manage my list of vehicles
  So that I can offer them for use on future trips

  Scenario: User can view the manage vehicles page
    Given I want to view my list of vehicles
    And I am logged in as a user
    When I go to the dashboard page
    And I follow "Manage Vehicles"
    Then I should be on the manage vehicles page

  Scenario: User can see list of added vehicles
    Given I want to view my list of vehicles
    And I am logged in as a user
    And I have added my "4" passenger "Toyota" "Corolla"
    And I have added my "4" passenger "Toyota" "Prius"
    When I go to the manage vehicles page
    Then I should see "Corolla"
    And I should see "Prius"

  Scenario: User can see info for each vehicle
    Given I want to view information about one of my vehicles
    And I am logged in as a user
    And I have added my "4" passenger "Toyota" "Corolla"
    When I go to the manage vehicles page
    Then I should see "Corolla"
    And I should see "Make"
    And I should see "Model"
    And I should see "Capacity"

  Scenario: User can add vehicle
    Given I want to add a vehicle
    And I am logged in as a user
    And I am on the manage vehicles page
    When I follow "Add Vehicle"
    Then I should be on the add vehicle page

  Scenario Outline: User adds vehicle
    Given I am logged in as a user
    And I am on the add vehicle page
    When I fill in "Make" with "<make>"
    And I fill in "Model" with "<model>"
    And I fill in "Capacity" with "<capacity>"
    Then I should see "<result>"

    Scenarios: with valid information
      | make   | model   | capacity | result        |
      | Toyota | Corolla | 4        | Vehicle Added |
      | Toyota | 4Runner | 4        | Vehicle Added |
      | Toyota | Sienna  | 8        | Vehicle Added |

    Scenarios: with invalid information
      | make   | model   | capacity | result        |
      |        | Corolla | 4        | Error         |
      | Toyota |         | 4        | Error         |
      | Toyota | Corolla | 0        | Error         |
      | Toyota | Corolla | -1       | Error         |

  Scenario: User removes vehicle
    Given I want to remove a vehicle
    And I am logged in as a user
    And I have added my "4" passenger "Toyota" "Corolla"
    And I am on the manage vehicles page
    When I follow "Remove Vehicle"
    Then I should not see "Corolla"
