Feature: User can log in

  As a user
  I want identify myself to the service
  So that I use the service as myself

  Scenario: User logs in with valid credentials
    Given I am not authenticated
    And I have one person "test@test.com" with password "testpassword"
    And I am on the sign in page
    When I fill in "person[email]" with "test@test.com"
    And I fill in "person[password]" with "testpassword"
    And I press "Sign in"
    Then I should be on the trips dashboard

  Scenario: User logs in with invalid credentials
    Given I am not authenticated
    And I have one person "test@test.com" with password "testpassword"
    And I am on the sign in page
    And I fill in "person[email]" with "test@test.com"
    And I fill in "person[password]" with "wrongpassword"
    When I press "Sign in"
    Then I should be on the sign in page