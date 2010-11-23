Feature: User can edit profile

  So that I can receive valid and favorable ride arrangements
  As a user
  I want to update my profile

  Background: I am signed in
    Given I am signed in with password "password123"

  Scenario: I can view the profile page
    Given I am on the dashboard page
    And I follow "Profile"
    Then I should be on the profile page
    
  Scenario: I can modify personal information
    When I go to the profile page
    Then I should see "Name"
    And I should see "Email"
    And I should see "Address"
    And I should see "Phone"

  Scenario: I can indicate personal preferences
    When I go to the profile page
    Then I should see "Music"
    And I should see "Smoking"

  Scenario Outline: I update my personal information
    Given I am on the profile page
    When I fill in "Password" with "password123"
    When I fill in "Name" with "<name>"
    And I fill in "Email" with "<email>"
    And I fill in "Address" with "<address>"
    And I fill in "Phone" with "<phone>"
    And I press "Update"
    Then I should see "<result>"

    Scenarios: with valid information
      | name     | email              | address                                              | phone            | result                                 |
#     | John Doe | John.Doe@gmail.com | 1600 Amphitheatre Pkwy, Mountain View, CA 94043, USA | 1231231234       | You updated your account successfully. |
#     | John Doe | John.Doe@gmail.com | 1600 Amphitheatre Pkwy, Mountain View, CA 94043      | 1231231234       | You updated your account successfully. |
#     | John Doe | John.Doe@gmail.com | 1600 Amphitheatre Pkwy, Mountain View, CA            | 1231231234       | You updated your account successfully. |
#     | John Doe | John.Doe@gmail.com | 1600 Amphitheatre Pkwy, Mountain View, California    | 1231231234       | You updated your account successfully. |
#     | John Doe | John.Doe@gmail.com | 1600 Amphitheatre Pkwy, Mountain View                | 1231231234       | You updated your account successfully. |
#     | John Doe | John.Doe@gmail.com | 1600 Amphitheatre Parkkway, Mountain View            | 1231231234       | You updated your account successfully. |
      | John Doe | John.Doe@gmail.com | 1600 Amphitheatre Parkway, Mountain View, CA         | 1234567890       | You updated your account successfully. |
      | John Doe | John.Doe@gmail.com | 1600 Amphitheatre Parkway, Mountain View, CA         | 123.456.7890     | You updated your account successfully. |
      | John Doe | John.Doe@gmail.com | 1600 Amphitheatre Parkway, Mountain View, CA         | 123-456-7890     | You updated your account successfully. |
      | John Doe | John.Doe@gmail.com | 1600 Amphitheatre Parkway, Mountain View, CA         | 123 456 7890     | You updated your account successfully. |
      | John Doe | John.Doe@gmail.com | 1600 Amphitheatre Parkway, Mountain View, CA         | (123) 456-7890   | You updated your account successfully. |

    Scenarios: with invalid information
      | name     | email              | address                                      | phone       | result                                               |
      |          | John.Doe@gmail.com | 1600 Amphitheatre Parkway, Mountain View, CA | 1231231234  | Name can't be blank                                  |
      | John Doe |                    | 1600 Amphitheatre Parkway, Mountain View, CA | 1231231234  | Email can't be blank                                 |
      | John Doe | gmail.com          | 1600 Amphitheatre Parkway, Mountain View, CA | 1231231234  | Email is invalid                                     |
#     | John Doe | John.Doe@gmail.com |                                              | 1231231234  | Address must be a valid street address               |
#     | John Doe | John.Doe@gmail.com | Amphitheatre Parkway, Mountain View, CA      | 1231231234  | Address must be a valid street address               |
#     | John Doe | John.Doe@gmail.com | 123 Address                                  | 1231231234  | Address must be a valid street address               |
#     | John Doe | John.Doe@gmail.com | String                                       | 1231231234  | Address must be a valid street address               |
      | John Doe | John.Doe@gmail.com | 1600 Amphitheatre Parkway, Mountain View, CA |             | Phone can't be blank                                 |
      | John Doe | John.Doe@gmail.com | 1600 Amphitheatre Parkway, Mountain View, CA | 12345678900 | Phone must be a complete and numeric US phone number |
      | John Doe | John.Doe@gmail.com | 1600 Amphitheatre Parkway, Mountain View, CA | aaaaaaaaaa  | Phone must be a complete and numeric US phone number |

  Scenario Outline: I update my personal preferences
    Given I am on the profile page
    When I fill in "Password" with "password123"
    And I choose "<music>"
    And I choose "<smoking>"
    And I press "Update"
    Then I should see "<result>"

    Scenarios: with valid information
      | music         | smoking       | result                                 |
      | No Preference | No Preference | You updated your account successfully. |
      | No Music      | No Smoking    | You updated your account successfully. |
      | Quiet Music   | No Smoking    | You updated your account successfully. |
      | Loud Music    | No Smoking    | You updated your account successfully. |
      | Loud Music    | Smoking       | You updated your account successfully. |
