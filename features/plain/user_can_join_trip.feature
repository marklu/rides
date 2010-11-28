Feature: User can join trip

    So that I participate in a trip
    As a user
    I want to join a trip I've been invited to

    Background: A registered user has been invited to a trip
        Given there exists a user with email "invitee@invitee.com" and password "invitee"
        And there is an invitation to "ExistingTrip" sent to "invitee@invitee.com" with token "69bb4880959b6708abd9b6cd95040412"
        #And user with email "invitee@invitee.com" has an invitation to future trip called "ExistingTrip"

    Scenario: A user that does not have the correct invitation token cannot join a trip
        Given I'm signed in as "invitee@invitee.com" and password "invitee"
        When I go to the manage trip page of "ExistingTrip"
        Then I should see "You do not have the correct token."

    Scenario: A user that has the correct invitation token can join a trip
        Given I'm signed in as "invitee@invitee.com" and password "invitee"
        And I'm on the manage trip page with token "69bb4880959b6708abd9b6cd95040412"
        When I press "Join this trip"
        Then I should be a participant in "ExistingTrip"
        And I should not have an invitation to "ExistingTrip"
