Feature: User can create trip

  As a user
  I want to create a new trip
  So that I can organize transportation for the participants

  Scenario: User can view the create trip page
	Given I want to create a trip
	And I have an account with email "test@test.com" and password "testpassword"
	And I am logged in as a user
	When I go to the trips dashboard
	And I follow "New Trip"
	Then I should be on the create trip page

  Scenario: User can create a new trip
	Given I want to create a trip
	And I have an account with email "test@test.com" and password "testpassword"
	And I am logged in as a user
	When I go to the create trip page
	Then I should see "Name" 
	And I should see "Time"
	And I should see "Address"
	And I should see "City"
	And I should see "State"

  Scenario Outline: User creates trip with valid time
	Given I want to create a trip
	And I have an account with email "test@test.com" and password "testpassword"
	And I am logged in as a user
	And I am on the create trip page
	When I select "December 25, 2010 10:00" as the date and time
	And I fill in "Name" with "<name>"
	And I fill in "Address" with "<address>"
	And I fill in "City" with "<city>"
	And I fill in "State" with "<state>"
	And I click on "Create trip"
	Then I should see "<result>"
	
	Scenarios: with valid information
		| name      | address          | city     | state      | result       |
		| Epic trip | 1 Infinite Drive | Berkeley | CA         | Trip created |
		| Epic trip | 1 Infinite Drive | Berkeley | California | Trip created |
	
	Scenarios: with invalid information
		| name      | address          | city     | state | result |
		|           | 1 Infinite Drive | Berkeley | CA    | Error  |
		| Epic trip |                  | Berkeley | CA    | Error  |
		| Epic trip | 1 Infinite Drive |          | CA    | Error  |
		| Epic trip | 1 Infinite Drive | Berkeley |       | Error  |
	
  Scenario Outline: User creates trip with invalid time
	Given I want to create a trip
	And I have an account with email "test@test.com" and password "testpassword"
	And I am logged in as a user
	And I am on the create trip page
	When I fill in "Name" with "<name>"
	And I fill in "Address" with "<address>"
	And I fill in "City" with "<city>"
	And I fill in "State" with "<state>"
	And I click on "Create trip"
	Then I should see "<result>"
	
	Scenarios: with valid information
		| name      | address          | city     | state      | result |
		| Epic trip | 1 Infinite Drive | Berkeley | CA         | Error  |
		| Epic trip | 1 Infinite Drive | Berkeley | California | Error  |
	
	Scenarios: with invalid information
		| name      | address          | city     | state | result |
		|           | 1 Infinite Drive | Berkeley | CA    | Error  |
		| Epic trip |                  | Berkeley | CA    | Error  |
		| Epic trip | 1 Infinite Drive |          | CA    | Error  |
		| Epic trip | 1 Infinite Drive | Berkeley |       | Error  |