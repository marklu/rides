Feature: Existing user can join trip

  So that I participate in a trip
  As a user
  I want to join a trip I've been invited to

  Background: A registered user has been invited to a trip
    Given there exists a user with email "organizer@organizer.com" and password "organizer"
    And user with email "organizer@organizer.com" is organizing a future trip called "ExistingTrip"
    And there exists a user with email "invitee@invitee.com" and password "invitee"
    And I'm signed in as "organizer@organizer.com" and password "organizer"
    And I am on the trip info page of "ExistingTrip"
    And I fill in "Enter email of user to invite" with "invitee@invitee.com"
    And I press "Invite"

  Scenario: A registered user that's been invited can join a trip
    And I'm signed in as "invitee@invitee.com" and password "invitee"
    And I am on the trip info page of "ExistingTrip"
    When I follow "Join This Trip"
    Then I should be a participant in "ExistingTrip"
    And I should not have an invitation to "ExistingTrip"



  Scenario: I can invite people by email

  Scenario: Invited user can view trip info

  Scenario: Invited user can join trip

  Scenario: Invited non-user can view trip info

  Scenario: Invited non-user can join trip after registration
