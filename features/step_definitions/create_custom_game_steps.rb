When(/^I am on the homepage$/) do
  visit root_path
end

When(/^I am on the games page$/) do
  visit games_path
end

When(/^I am on the new game page$/) do
  visit new_game_path
end

Then(/^I should see the welcome message$/) do
  expect(page).to have_content("Let's play HANGMAN!")
end

Then(/^I should see the link to games$/) do
  have_link("Go to games")
end

And(/^I click on the link to games$/) do
  click_link("Go to games")
end

Then(/^I should go the games page$/) do
  expect(page).to have_current_path("/games")
end

Then(/^I should see a link to custom game$/) do
  have_link("Create a custom game")
end

When(/^I click on the custom game link$/) do
  click_link("Create a custom game")
end

Then(/^I should go the new game page$/) do
  expect(page).to have_current_path("/games/new")
end

And(/^I enter a word$/) do
  fill_in('Word', with: 'FooBar')
end

Then(/^I click create game$/) do
  click_on('Create Game')
end

Then(/^I have created a game$/) do
  expect(Game.all.count).to eq 1
end

And(/^I should go the game show page$/) do
  game_id = Game.first.id
  expect(page).to have_current_path("/games/#{game_id}")
end
