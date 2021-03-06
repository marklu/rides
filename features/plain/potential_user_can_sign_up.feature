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
    And I fill in "Location" with "<location>"
    And I press "Sign up"
    Then I should be on the <page> page
    And I should see "<result>"

    Scenarios: with valid information
      | email           | password        | confirm         | name       | phone          | location                                             | page      | result                           |
      | email@email.com | testpassword123 | testpassword123 | First Last | 1234567890     | 1600 Amphitheatre Parkway, Mountain View, CA         | dashboard | You have signed up successfully. |
      | email@email.com | testpassword123 | testpassword123 | First Last | 123.456.7890   | 1600 Amphitheatre Parkway, Mountain View, CA         | dashboard | You have signed up successfully. |
      | email@email.com | testpassword123 | testpassword123 | First Last | 123-456-7890   | 1600 Amphitheatre Parkway, Mountain View, CA         | dashboard | You have signed up successfully. |
      | email@email.com | testpassword123 | testpassword123 | First Last | 123 456 7890   | 1600 Amphitheatre Parkway, Mountain View, CA         | dashboard | You have signed up successfully. |
      | email@email.com | testpassword123 | testpassword123 | First Last | (123) 456-7890 | 1600 Amphitheatre Parkway, Mountain View, CA         | dashboard | You have signed up successfully. |
      | email@email.com | testpassword123 | testpassword123 | First Last | (123) 456-7890 | 1600 Amphitheatre Pkwy, Mountain View, CA 94043, USA | dashboard | You have signed up successfully. |
      | email@email.com | testpassword123 | testpassword123 | First Last | (123) 456-7890 | 1600 Amphitheatre Pkwy, Mountain View, CA 94043      | dashboard | You have signed up successfully. |
      | email@email.com | testpassword123 | testpassword123 | First Last | (123) 456-7890 | 1600 Amphitheatre Pkwy, Mountain View, CA            | dashboard | You have signed up successfully. |
      | email@email.com | testpassword123 | testpassword123 | First Last | (123) 456-7890 | 1600 Amphitheatre Pkwy, Mountain View, California    | dashboard | You have signed up successfully. |
      | email@email.com | testpassword123 | testpassword123 | First Last | (123) 456-7890 | 1600 Amphitheatre Pkwy, Mountain View                | dashboard | You have signed up successfully. |
      | email@email.com | testpassword123 | testpassword123 | First Last | (123) 456-7890 | Soda Hall, Berkeley, CA                              | dashboard | You have signed up successfully. |
      | email@email.com | testpassword123 | testpassword123 | First Last | (123) 456-7890 | People's Park, Berkeley, CA                          | dashboard | You have signed up successfully. |
      | email@email.com | testpassword123 | testpassword123 | First Last | (123) 456-7890 | Yosemite National Park                               | dashboard | You have signed up successfully. |

    Scenarios: with invalid information
      | email           | password        | confirm              | name       | phone         | location                                     | page    | result                                       |
      |                 | testpassword123 | testpassword123      | First Last | 123-456-7890  | 1600 Amphitheatre Parkway, Mountain View, CA | sign up | Email can't be blank                         |
      | invalidemail    | testpassword123 | testpassword123      | First Last | 123-456-7890  | 1600 Amphitheatre Parkway, Mountain View, CA | sign up | Email is invalid                             |
      | email@email.com |                 | testpassword123      | First Last | 123-456-7890  | 1600 Amphitheatre Parkway, Mountain View, CA | sign up | Password can't be blank                      |
      | email@email.com | 12345           | 12345                | First Last | 123-456-7890  | 1600 Amphitheatre Parkway, Mountain View, CA | sign up | Password is too short                        |
      | email@email.com | testpassword123 | differentpassword456 | First Last | 123-456-7890  | 1600 Amphitheatre Parkway, Mountain View, CA | sign up | Password doesn't match confirmation          |
      | email@email.com | testpassword123 |                      | First Last | 123-456-7890  | 1600 Amphitheatre Parkway, Mountain View, CA | sign up | Password doesn't match confirmation          |
      | email@email.com | testpassword123 | testpassword123      |            | 123-456-7890  | 1600 Amphitheatre Parkway, Mountain View, CA | sign up | Name can't be blank                          |
      | email@email.com | testpassword123 | testpassword123      | First Last |               | 1600 Amphitheatre Parkway, Mountain View, CA | sign up | Phone can't be blank                         |
      | email@email.com | testpassword123 | testpassword123      | First Last | 12345678900   | 1600 Amphitheatre Parkway, Mountain View, CA | sign up | Phone is not a valid numeric US phone number |
      | email@email.com | testpassword123 | testpassword123      | First Last | aaaaaaaaaa    | 1600 Amphitheatre Parkway, Mountain View, CA | sign up | Phone is not a valid numeric US phone number |
      | email@email.com | testpassword123 | testpassword123      | First Last | 123-456-7890  |                                              | sign up | Location location is invalid                 |
      | email@email.com | testpassword123 | testpassword123      | First Last | 123-456-7890  | Amphitheatre Parkway, Mountain View, CA      | sign up | Location location is invalid                 |
      | email@email.com | testpassword123 | testpassword123      | First Last | 123-456-7890  | 123 Address                                  | sign up | Location location is invalid                 |
      | email@email.com | testpassword123 | testpassword123      | First Last | 123-456-7890  | String                                       | sign up | Location location is invalid                 |

  Scenario: I see the entered information in my profile
    Given I am on the sign up page
    When I fill in "Email" with "email@email.com"
    And I fill in "Password" with "testpassword123"
    And I fill in "Confirm" with "testpassword123"
    And I fill in "Name" with "First Last"
    And I fill in "Phone" with "123-456-7890"
    And I fill in "Location" with "1600 Amphitheatre Parkway, Mountain View, CA"
    And I press "Sign up"
    And I follow "Profile"
    Then the "Email" field should contain "email@email.com"
    And the "Name" field should contain "First Last"
    And the "Phone" field should contain "(123) 456-7890"
    And the "Location" field should contain "1600 Amphitheatre Parkway, Mountain View, CA"

  Scenario Outline: I see a formatted version of my phone number in my profile
    Given I am on the sign up page
    When I fill in "Email" with "email@email.com"
    And I fill in "Password" with "testpassword123"
    And I fill in "Confirm" with "testpassword123"
    And I fill in "Name" with "First Last"
    And I fill in "Phone" with "<phone>"
    And I fill in "Location" with "1600 Amphitheatre Parkway, Mountain View, CA"
    And I press "Sign up"
    And I follow "Profile"
    Then the "Phone" field should contain "<formatted>"

    Scenarios: Given a valid phone number
      | phone          | formatted      |
      | 1234567890     | (123) 456-7890 |
      | 123.456.7890   | (123) 456-7890 |
      | 123-456-7890   | (123) 456-7890 |
      | 123 456 7890   | (123) 456-7890 |
      | (123) 456-7890 | (123) 456-7890 |

  Scenario: I have neutral default preferences
    Given I am on the sign up page
    When I fill in "Email" with "email@email.com"
    And I fill in "Password" with "testpassword123"
    And I fill in "Confirm" with "testpassword123"
    And I fill in "Name" with "First Last"
    And I fill in "Phone" with "123-456-7890"
    And I fill in "Location" with "1600 Amphitheatre Parkway, Mountain View, CA"
    And I press "Sign up"
    And I follow "Profile"
    Then the "No preference" radio button for "Music" should be selected
    And the "No preference" radio button for "Smoking" should be selected
