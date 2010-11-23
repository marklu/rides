Feature: Potential user can sign up

  So that I can identify myself as a user of the service
  As a potential user
  I want to sign up as a user

  Scenario Outline: I can autocomplete my address
    Given I am on the sign up page
    When I type "<address>" into "Address"
    Then I should see "<autocomplete>"

    Scenarios: with a valid address
      | address                   | autocomplete                                         |
      | 1600 Amphitheatre Parkway | 1600 Amphitheatre Pkwy, Mountain View, CA 94043, USA |
      | 1 Infinite Loop           | 1 Infinite Loop, Cupertino, CA 95014, USA            |
      | 795 Folsom St             | 795 Folsom St, San Francisco, CA 94107, USA          |
      | 1601 South California Ave | 1601 S California Ave, Palo Alto, CA 94304, USA      |

  Scenario: I autocomplete my address
    Given I am on the sign up page
    When I type "1600 Amphitheatre Parkway" into "Address"
    And I select "1600 Amphitheatre Pkwy, Mountain View, CA 94043, USA"
    Then "Address" should contain "1600 Amphitheatre Pkwy, Mountain View, CA 94043, USA"