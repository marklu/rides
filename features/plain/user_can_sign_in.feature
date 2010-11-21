Feature: User can sign in

  So that I can use the service
  As a user
  I want to identify myself to the service

  Background: I am signed up
    Given I am signed up with email "email@email.com" and password "testpassword123"

  Scenario: I can view the sign in page
    Given I am on the home page
    When I follow "Sign in"
    Then I should be on the sign in page

  Scenario: I sign in with valid credentials
    Given I am on the sign in page
    When I fill in "Email" with "email@email.com"
    And I fill in "Password" with "testpassword123"
    And I press "Sign in"
    Then I should see "Signed in successfully."

  Scenario: I sign in with invalid credentials
    Given I am on the sign in page
    And I fill in "Email" with "email@email.com"
    And I fill in "Password" with "wrongpassword123"
    When I press "Sign in"
    Then I should be on the sign in page