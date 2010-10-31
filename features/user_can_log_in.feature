Feature: User can log in

  As a user
  I want identify myself to the service
  So that I use the service as myself

  Scenario: User logs in with valid credentials
    Given I am on the sign in page
    And I fill in "person_email" with "test@test.com"
    And I fill in "person_password" with "testpassword"
    When I press "Sign in"
    Then I should see "Dashboard"

  Scenario: User logs in with invalid credentials

