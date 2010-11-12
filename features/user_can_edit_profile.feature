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
    And I should see "City"
    And I should see "State"
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
    And I fill in "City" with "<city>"
    And I fill in "State" with "<state>"
    And I fill in "Phone" with "<phone>"
    And I press "Update"
    Then I should see "<result>"

    Scenarios: with valid information
      | name     | email              | address         | city      | state      | phone            | result                                 |
      | John Doe | John.Doe@gmail.com | 1 Infinite Loop | Cupertino | CA         | 1231231234       | You updated your account successfully. |
      | John Doe | John.Doe@gmail.com | 1 Infinite Loop | Cupertino | California | 1231231234       | You updated your account successfully. |
      | John Doe | John.Doe@gmail.com | 1 Infinite Loop | Cupertino | CA         | 11231231234      | You updated your account successfully. |
      | John Doe | John.Doe@gmail.com | 1 Infinite Loop | Cupertino | CA         | (123) 123-1234   | You updated your account successfully. |
      | John Doe | John.Doe@gmail.com | 1 Infinite Loop | Cupertino | CA         | 1 (123) 123-1234 | You updated your account successfully. |

    Scenarios: with invalid information
      | name     | email              | address         | city      | state | phone      | result |
      |          | John.Doe@gmail.com | 1 Infinite Loop | Cupertino | CA    | 1231231234 | error  |
      | John Doe |                    | 1 Infinite Loop | Cupertino | CA    | 1231231234 | error  |
      | John Doe | gmail.com          | 1 Infinite Loop | Cupertino | CA    | 1231231234 | error  |
      | John Doe | John.Doe@gmail.com |                 | Cupertino | CA    | 1231231234 | error  |
      | John Doe | John.Doe@gmail.com | 1 Infinite Loop |           | CA    | 1231231234 | error  |
      | John Doe | John.Doe@gmail.com | 1 Infinite Loop | Cupertino |       | 1231231234 | error  |
      | John Doe | John.Doe@gmail.com | 1 Infinite Loop | Cupertino | CA    |            | error  |

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
