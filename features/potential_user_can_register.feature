Feature: Potential user can register

  As a potential user
  I want to register my identity with the service
  So that I can use the service as myself

  Scenario: Potential user registers with valid information
    Given I am not authenticated
    And I am on the sign up page
    When I fill in "Email" with "testregister@test.com"
    And I fill in "Password" with "testpassword"
    And I fill in "Password confirmation" with "testpassword"
    And I fill in "Name" with "Test Register"
    And I fill in "Phone" with "123-456-7890"
    And I fill in "Address" with "123 Register St."
    And I fill in "City" with "Registerville"
    And I fill in "State" with "CA"
    And I press "Sign up"
    Then I should be on the trips dashboard
    And I should see "You have signed up successfully."

  Scenario Outline: Potential user registers with invalid information
    Given I am not authenticated
    And I am on the sign up page
    When I fill in "Email" with "<email>"
    And I fill in "Password" with "<password>"
    And I fill in "Password confirmation" with "<confirmation>"
    And I fill in "Name" with "<name>"
    And I fill in "Phone" with "<phone>"
    And I fill in "Address" with "<address>"
    And I fill in "City" with "<city>"
    And I fill in "State" with "<state>"
    And I press "Sign up"
    Then I should be on the person registration page
    And I should see "<result>"

    Scenarios: with invalid information
            | email          | password     | confirmation | name         | phone         | address      | city          | state | result                               |
            |                | testpassword | testpassword | RegisterName | 123-456-7890  | 123 Main St. | Registerville | CA    | Email can't be blank                 |
            | test2@test.com |              | testpassword | RegisterName | 123-456-7890  | 123 Main St. | Registerville | CA    | Password can't be blank              |
            | test2@test.com | srt          | srt          | RegisterName | 123-456-7890  | 123 Main St. | Registerville | CA    | Password is too short                |
            | test2@test.com | password1    | password2    | RegisterName | 123-456-7890  | 123 Main St. | Registerville | CA    | Password doesn't match confirmation  |
            | test2@test.com | testpassword |              | RegisterName | 123-456-7890  | 123 Main St. | Registerville | CA    | Password doesn't match confirmation  |
            | test2@test.com | testpassword | testpassword |              | 123-456-7890  | 123 Main St. | Registerville | CA    | Name can't be blank                  |
            | test2@test.com | testpassword | testpassword | RegisterName |               | 123 Main St. | Registerville | CA    | Phone can't be blank                 |
            | test2@test.com | testpassword | testpassword | RegisterName | 123-456-7890  |              | Registerville | CA    | Address can't be blank               |
            | test2@test.com | testpassword | testpassword | RegisterName | 123-456-7890  | 123 Main St. |               | CA    | City can't be blank                  |
            | test2@test.com | testpassword | testpassword | RegisterName | 123-456-7890  | 123 Main St. | Registerville |       | State can't be blank                 |
            | asdfasdfasdf   | testpassword | testpassword | RegisterName | 123-456-7890  | 123 Main St. | Registerville | CA    | Email is invalid                     |

  Scenario: Newly registered user sees entered information in profile

  Scenario: Newly registered user has neutral personal preferences
