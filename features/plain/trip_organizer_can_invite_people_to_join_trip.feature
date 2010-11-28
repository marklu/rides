Feature: Trip organizer can invite people to join trip

  So that I can organize rides for the participants of my trip
  As a trip organizer
  I want to invite people to join the trip

  Background: There's a trip to be invited to
    Given there exists a user with email "organizer@organizer.com" and password "organizer"
    And there exists a user with email "invitee@invitee.com" and password "invitee"
    And user with email "organizer@organizer.com" is organizing a future trip called "ExistingTrip"

  Scenario: I can invite existing, registered users to join a trip
    Given I'm signed in as "organizer@organizer.com" and password "organizer"
    And I am on the trip info page of "ExistingTrip"
    When I fill in "Enter email of user to invite" with "invitee@invitee.com"
    And I press "Invite"
    Then the user with email "invitee@invitee.com" should have an invitation to "ExistingTrip"

  Scenario: I cannot invite an existing, registered user to join a trip if he already has an invitation to that trip
    Given I'm signed in as "organizer@organizer.com" and password "organizer"
    And I am on the trip info page of "ExistingTrip"
    And I fill in "Enter email of user to invite" with "invitee@invitee.com"
    And I press "Invite"
    When I fill in "Enter email of user to invite" with "invitee@invitee.com"
    And I press "Invite"
    Then I should see "Email already has an invitation."

  Scenario: I cannot invite an existing, registered user to join a trip if he is already participating in that trip
    Given I'm signed in as "organizer@organizer.com" and password "organizer"
    And the user with email "invitee@invitee.com" is participating in "ExistingTrip"
    And I am on the trip info page of "ExistingTrip"
    When I fill in "Enter email of user to invite" with "invitee@invitee.com"
    And I press "Invite"
    And I should see " is already a participant of that trip."

  Scenario: I can invite a non-existing user to join a trip
    Given I'm signed in as "organizer@organizer.com" and password "organizer"
    And I am on the trip info page of "ExistingTrip"
    When I fill in "Enter email of user to invite" with "jasonxku@gmail.com"
    And I press "invite"
    And I should see "jasonxku@gmail.com has not registered yet. Invitation to join site has been sent."
  
  Scenario: I cannot invite a non-existing user to join a trip if he already has an invitation to that trip
    Given I'm signed in as "organizer@organizer.com" and password "organizer"
    And I am on the trip info page of "ExistingTrip"
    And I fill in "Enter email of user to invite" with "jasonxku@gmail.com"
    And I press "Invite"
    When I fill in "Enter email of user to invite" with "jasonxku@gmail.com"
    And I press "Invite"
    Then I should see "Email already has an invitation."