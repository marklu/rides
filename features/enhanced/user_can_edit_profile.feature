Feature: User can edit profile

  So that I can receive valid and favorable ride arrangements
  As a user
  I want to update my profile

  Background: I am signed in
    Given I am signed in

  Scenario Outline: I can autocomplete my location
    Given I am on the profile page
    When I type "<location>" into "Location"
    Then I should see "<autocomplete>"

    Scenarios: with a valid location
      | location                  | autocomplete                                         |
      | 1600 Amphitheatre Parkway | 1600 Amphitheatre Pkwy, Mountain View, CA 94043, USA |
      | 1 Infinite Loop           | 1 Infinite Loop, Cupertino, CA 95014, USA            |
      | 795 Folsom St             | 795 Folsom St, San Francisco, CA 94107, USA          |
      | 1601 South California Ave | 1601 S California Ave, Palo Alto, CA 94304, USA      |

  Scenario: I autocomplete my location
    Given I am on the profile page
    When I type "1600 Amphitheatre Parkway" into "Location"
    And I select "1600 Amphitheatre Pkwy, Mountain View, CA 94043, USA"
    Then "Location" should contain "1600 Amphitheatre Pkwy, Mountain View, CA 94043, USA"
