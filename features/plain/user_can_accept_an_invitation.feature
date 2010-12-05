Feature: User can accept an invitation

  So that I may participate in a trip
  As a user
  I want to join a trip to which I have been invited

  Background: I have been invited to a trip
    Given I am signed up
    And there is an upcoming trip named "Company Picnic"
    And I have been invited to participate with token "token"

  Scenario: I receive an invitation email
    Then I should receive an email with subject "Invitation to Participate in the Company Picnic"

  Scenario: I see details about the trip
    When I open the email
    Then I should see "Company Picnic" in the email body
    And I should see "Place" in the email body
    And I should see "Time" in the email body

  Scenario: I accept the invitation via manual token entry
    When I sign in
    And I go to the join trip page
    And I fill in "Token" with "token"
    And I press "Join Trip"
    Then I should see "You are now a participant"

  Scenario: I try to accept the invitation via manual token entry with an invalid token
    When I sign in
    And I go to the join trip page
    And I fill in "Token" with "invalid"
    And I press "Join Trip"
    Then I should see "The token you entered is invalid."

  Scenario: I accept the invitation via email link while signed in
    When I sign in 
    And I open the email
    And I follow "join" in the email
    And I press "Join Trip"
    Then I should see "You are now a participant"

  Scenario: I accept the invitation via email link while signed out
    When I open the email
    And I follow "join" in the email
    And I fill in "Email" with "myemail@email.com"
    And I fill in "Password" with "testpassword123"
    And I press "Sign in"
    And I press "Join Trip"
    Then I should see "You are now a participant"
