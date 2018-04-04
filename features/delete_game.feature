Feature: Delete Game
  As a gamer
  I want a link to delete existing games

Background:
  Given Two existing games

Scenario: User sees delete links
  When I am on the games page
  Then I should see a list of games
  And I should see links to delete the games

Scenario: User clicks the delete link on a game
  When I am on the games page
  And I click on the delete link of the top game
  Then I should go the games page
  And The game should be gone
