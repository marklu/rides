Feature: Trip organizer can invite people to join trip

  So that I can have transportation organized for those interested in participating in the trip
  As a trip organizer
  I want to invite people to join the trip

  Background: I am organizing an upcoming trip
    Given I am signed in
    And I am organizing an upcoming trip named "Company Picnic"

  Scenario: I invite a non-user to participate in the trip
    When I go to the trip participants page
    And I fill in "Email" with "alice@email.com"
    And I press "Invite"
    Then "Alice" should be invited to participate in the trip
    And "alice@email.com" should receive an email with subject "Invitation to Participate in the Company Picnic"
    And I should see "alice@email.com has been invited."

  Scenario: I invite a user to participate in the trip
    Given "Alice" has signed up
    When I go to the trip participants page
    And I fill in "Email" with "alice@email.com"
    And I press "Invite"
    Then "Alice" should be invited to participate in the trip
    And "alice@email.com" should receive an email with subject "Invitation to Participate in the Company Picnic"
    And I should see "alice@email.com has been invited."

  Scenario: I invite an already invited person to participate in the trip
    Given "Alice" has signed up
    And "Alice" has already been invited to participate in the trip
    When I go to the trip participants page
    And I fill in "Email" with "alice@email.com"
    And I press "Invite"
    Then "alice@email.com" should receive no email
    And I should see "Email already has an invitation."

  Scenario: I invite a participant to participate in the trip
    Given "Alice" is a participant
    When I go to the trip participants page
    And I fill in "Email" with "alice@email.com"
    And I press "Invite"
    Then "alice@email.com" should receive no email
    And I should see "is already a participant of that trip."

  Scenario: I can see a list of invited people
    Given "Alice" has already been invited to participate in the trip
    When I go to the trip participants page
    Then I should see "alice@email.com"