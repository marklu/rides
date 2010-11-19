Feature: Potential user can sign up

  So that I can identify myself as a user of the service
  As a potential user
  I want to sign up as a user

  Scenario: I can view the sign up page
    Given I am on the home page
    When I follow "Sign up"
    Then I should be on the sign up page

  Scenario Outline: I sign up
    Given I am on the sign up page
    When I fill in "Email" with "<email>"
    And I fill in "Password" with "<password>"
    And I fill in "Confirm" with "<confirm>"
    And I fill in "Name" with "<name>"
    And I fill in "Phone" with "<phone>"
    And I fill in "Address" with "<address>"
    And I press "Sign up"
    Then I should be on the <page> page
    And I should see "<result>"

    Scenarios: with valid information
      | email           | password        | confirm         | name       | phone        | address                                      | page      | result                           |
      | email@email.com | testpassword123 | testpassword123 | First Last | 123-456-7890 | 1600 Amphitheatre Parkway, Mountain View, CA | dashboard | You have signed up successfully. |

    Scenarios: with invalid information
      | email           | password        | confirm              | name       | phone         | address                                      | page    | result                                 |
      |                 | testpassword123 | testpassword123      | First Last | 123-456-7890  | 1600 Amphitheatre Parkway, Mountain View, CA | sign up | Email can't be blank                   |
      | invalidemail    | testpassword123 | testpassword123      | First Last | 123-456-7890  | 1600 Amphitheatre Parkway, Mountain View, CA | sign up | Email is invalid                       |
      | email@email.com |                 | testpassword123      | First Last | 123-456-7890  | 1600 Amphitheatre Parkway, Mountain View, CA | sign up | Password can't be blank                |
      | email@email.com | 12345           | 12345                | First Last | 123-456-7890  | 1600 Amphitheatre Parkway, Mountain View, CA | sign up | Password is too short                  |
      | email@email.com | testpassword123 | differentpassword456 | First Last | 123-456-7890  | 1600 Amphitheatre Parkway, Mountain View, CA | sign up | Password doesn't match confirmation    |
      | email@email.com | testpassword123 |                      | First Last | 123-456-7890  | 1600 Amphitheatre Parkway, Mountain View, CA | sign up | Password doesn't match confirmation    |
      | email@email.com | testpassword123 | testpassword123      |            | 123-456-7890  | 1600 Amphitheatre Parkway, Mountain View, CA | sign up | Name can't be blank                    |
      | email@email.com | testpassword123 | testpassword123      | First Last |               | 1600 Amphitheatre Parkway, Mountain View, CA | sign up | Phone can't be blank                   |
      | email@email.com | testpassword123 | testpassword123      | First Last | 123-456-7890  |                                              | sign up | Address must be a valid street address |
      | email@email.com | testpassword123 | testpassword123      | First Last | 123-456-7890  | Amphitheatre Parkway, Mountain View, CA      | sign up | Address must be a valid street address |
      | email@email.com | testpassword123 | testpassword123      | First Last | 123-456-7890  | 123 Address                                  | sign up | Address must be a valid street address |
      | email@email.com | testpassword123 | testpassword123      | First Last | 123-456-7890  | String                                       | sign up | Address must be a valid street address |

  Scenario: I see the entered information in my profile
    Given I am on the sign up page
    When I fill in "Email" with "email@email.com"
    And I fill in "Password" with "testpassword123"
    And I fill in "Confirm" with "testpassword123"
    And I fill in "Name" with "First Last"
    And I fill in "Phone" with "123-456-7890"
    And I fill in "Address" with "1600 Amphitheatre Parkway, Mountain View, CA"
    And I press "Sign up"
    And I follow "Profile"
    Then the "Email" field should contain "email@email.com"
    And the "Name" field should contain "First Last"
    And the "Phone" field should contain "123-456-7890"
    And the "Address" field should contain "1600 Amphitheatre Parkway, Mountain View, CA"

  Scenario: I have neutral default preferences
    Given I am on the sign up page
    When I fill in "Email" with "email@email.com"
    And I fill in "Password" with "testpassword123"
    And I fill in "Confirm" with "testpassword123"
    And I fill in "Name" with "First Last"
    And I fill in "Phone" with "123-456-7890"
    And I fill in "Address" with "1600 Amphitheatre Parkway, Mountain View, CA"
    And I press "Sign up"
    And I follow "Profile"
    Then the "No preference" radio button for "Music" should be selected
    And the "No preference" radio button for "Smoking" should be selected
