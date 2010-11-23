Feature: User can create trip

  So that I can organize transportation for my trip
  As a user
  I want to plan a new trip

  Background: I am signed in
    Given I am signed in

  Scenario Outline: I can autocomplete my address
    Given I am on the plan trip page
    When I type "<address>" into "Address"
    Then I should see "<autocomplete>"

    Scenarios: with a valid address
      | address                   | autocomplete                                         |
      | 1600 Amphitheatre Parkway | 1600 Amphitheatre Pkwy, Mountain View, CA 94043, USA |
      | 1 Infinite Loop           | 1 Infinite Loop, Cupertino, CA 95014, USA            |
      | 795 Folsom St             | 795 Folsom St, San Francisco, CA 94107, USA          |
      | 1601 South California Ave | 1601 S California Ave, Palo Alto, CA 94304, USA      |

  Scenario: I autocomplete my address
    Given I am on the plan trip page
     When I type "1600 Amphitheatre Parkway" into "Address"
     And I select "1600 Amphitheatre Pkwy, Mountain View, CA 94043, USA"
     Then "Address" should contain "1600 Amphitheatre Pkwy, Mountain View, CA 94043, USA"
