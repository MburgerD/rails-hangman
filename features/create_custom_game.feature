Feature: Custom Game
  As a gamer
  I want to see a heading when I visit the site
  I want a link to get to the games page
  I want to be able to create a new custom game

Scenario: User sees the welcome message
  When I am on the homepage
  Then I should see the welcome message
  Then I should see the link to games

Scenario: User navigates to games page, sees link
  When I am on the homepage
  And I click on the link to games
  Then I should go the games page
  Then I should see a link to custom game

Scenario: User goes to new game page
  When I am on the games page
  When I click on the custom game link
  Then I should go the new game page

Scenario: User creates a new game
  When I am on the new game page
  And I enter a word
  Then I click create game
  Then I have created a game
  And I should go the game show page
