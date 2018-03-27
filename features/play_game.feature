Feature: Play Game
	As a gamer
	I want to see the existing games
	I want a link to go to the existing game
	I want to be able to submit a guess
	I want a link to go back to the list of games

Background:
  Given Two existing games

Scenario: User sees a list of games
	When I am on the games page
	Then I should see a list of games
	And I should see links to games

Scenario: User clicks the show link on a game
	When I am on the games page
	And I click on the show link of the top game
	Then I should go the game show page

Scenario: User makes a guess
	When I am on the game show page
	And I enter a guess
	Then I click update game
	And I should go the game show page

Scenario: User clicks the back link in a game
	When I am on the game show page
	And I click on the back link
	Then I should go the games page
