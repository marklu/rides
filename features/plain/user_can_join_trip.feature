Feature: User can join trip

  So that I may participate in a trip
  As a user
  I want to join a trip to which I have been invited

  Background: I have been invited to a trip
    Given I am signed in
    And there is an upcoming trip named "Company Picnic"
    And I have been invited to participate with token "token"

  Scenario: I try to join the trip without the token
#    When I go to the manage trip page
#    Then I should see "You do not have the correct token."

  Scenario: I try to join the trip with an invalid token

  Scenario: I join the trip with the token