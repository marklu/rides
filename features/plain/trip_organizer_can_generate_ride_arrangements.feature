Feature: Trip organizer can generate ride arrangements

  So that I can ensure that every trip participant can participate on a trip
  As a trip organizer
  I want to generate ride arrangements

  Background: I am the organizer in an upcoming trip having other participants and vehicles
    Given I am signed in
    And I am organizing an upcoming trip named "Company Picnic"
    And the following people are participants:
      | name  |
      | Alice |
      | Bob   |
      | Chris |
      | Dave  |
    And the following people have the following cars:
      | owner | make   | model |
      | Alice | Honda  | Civic |
      | Dave  | Toyota | Camry | 

  Scenario: I want to generate ride arrangements
    Given the following people are driving:
      | name |
      | Dave |
    When I go to the trip info page
    And I press "Generate Arrangements"
    And I go to the all arrangements page
    Then I should see "Dave"
    And I should see "Alice"
    And I should see "Bob"
    And I should see "Chris"
