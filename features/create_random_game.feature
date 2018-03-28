Feature: Random Game
	As a gamer
	I want a button to create a random game on the games page
	I want a game to be created when I click the button

Scenario: User sees random game button on games page
	When I am on the games page
	Then I should see a button to create a random game

Scenario: User creates a random game
	When I am on the games page
	And I click the random game button
	Then I have created a game
	And I should go the game show page
