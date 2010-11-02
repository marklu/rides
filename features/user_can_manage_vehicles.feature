Feature: User can manage vehicles

  As a user
  I want to manage my list of vehicles
  So that I can offer them for use on future trips

  Scenario: User can see list of added vehicles
    Given I have an account with email "test@test.com" and password "testpassword"
    Given I want to view my list of vehicles
    And I am logged in as a user
    And I have added my "4" passenger "Toyota" "Corolla"
    And I have added my "4" passenger "Toyota" "Prius"
    When I go to the edit profile page
    Then I should see "Corolla"
    And I should see "Prius"

  Scenario: User can see info for each vehicle
    Given I have an account with email "test@test.com" and password "testpassword"
    Given I want to view information about one of my vehicles
    And I am logged in as a user
    And I have added my "4" passenger "Toyota" "Corolla"
    When I go to the edit profile page
    Then I should see "Corolla"
    And I should see "Make"
    And I should see "Model"
    And I should see "Capacity"

  Scenario: User can add vehicle
    Given I have an account with email "test@test.com" and password "testpassword"
    Given I want to add a vehicle
    And I am logged in as a user
    And I am on the edit profile page
    When I follow "Add Vehicle"
    Then I should be on the add vehicle page

  Scenario Outline: User adds vehicle
    Given I have an account with email "test@test.com" and password "testpassword"
    Given I am logged in as a user
    And I am on the add vehicle page
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

  Scenario: User updates vehicle
    Given I have an account with email "test@test.com" and password "testpassword"
    And I am logged in as a user
    And I have added my "4" passenger "Toyota" "Corolla"
    And I am on the edit profile page
    When I follow "Update Vehicle"
    And I fill in "Model" with "Camry"
    And I press "Update Vehicle"
    Then I should see "Camry"

  Scenario: User removes vehicle
    Given I have an account with email "test@test.com" and password "testpassword"
    Given I want to remove a vehicle
    And I am logged in as a user
    And I have added my "4" passenger "Toyota" "Corolla"
    And I am on the edit profile page
    When I follow "Remove Vehicle"
    Then I should not see "Corolla"
