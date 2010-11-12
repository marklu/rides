Feature: User can manage vehicles

  So that I can offer my vehicles for use on future trips
  As a user
  I want to manage my list of vehicles

  Background: I am signed in
    Given I am signed in

  Scenario: I can add a vehicle
    Given I am on the profile page
    When I follow "Add Vehicle"
    Then I should be on the add vehicle page

  Scenario Outline: I add a vehicle
    Given I am on the add vehicle page
    When I fill in "Make" with "<make>"
    And I fill in "Model" with "<model>"
    And I fill in "Capacity" with "<capacity>"
    And I press "Create Vehicle"
    Then I should see "<result>"

    Scenarios: with valid information
      | make   | model   | capacity | result                          |
      | Toyota | Corolla | 4        | Vehicle was successfully added. |
      | Toyota | 4Runner | 4        | Vehicle was successfully added. |
      | Toyota | Sienna  | 8        | Vehicle was successfully added. |

    Scenarios: with invalid information
      | make   | model   | capacity | result |
      |        | Corolla | 4        | error  |
      | Toyota |         | 4        | error  |
      | Toyota | Corolla | 0        | error  |
      | Toyota | Corolla | -1       | error  |

  Scenario: I can see a list of added vehicles
    Given I have added my "4" passenger "Toyota" "Corolla"
    And I have added my "4" passenger "Toyota" "Prius"
    When I go to the profile page
    Then I should see "Corolla"
    And I should see "Prius"

  Scenario: I can see info for each vehicle
    Given I have added my "4" passenger "Toyota" "Corolla"
    When I go to the profile page
    Then I should see "Corolla"
    And I should see "Make"
    And I should see "Model"
    And I should see "Capacity"

  Scenario: I update a vehicle
    Given I have added my "4" passenger "Toyota" "Corolla"
    And I am on the profile page
    When I follow "Update Vehicle"
    And I fill in "Model" with "Camry"
    And I press "Update Vehicle"
    Then I should see "Camry"

  Scenario: I remove a vehicle
    Given I have added my "4" passenger "Toyota" "Corolla"
    And I am on the profile page
    When I follow "Remove Vehicle"
    Then I should not see "Corolla"
