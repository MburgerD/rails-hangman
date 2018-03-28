Given(/^Two existing games$/) do
  Game.create word: 'foo', lives: 5
  Game.create word: 'bar', lives: 5
end

Then(/^I should see a list of games$/) do
  within "tbody" do
    expect(page).to have_css("tr", count: 2)
  end
end

And(/^I should see links to games$/) do
  have_link("show", count: 2)
end

And(/^I click on the show link of the top game$/) do
  within "tbody" do
    first("tr").click_link("Show")
  end
end

When(/^I am on the game show page$/) do
  visit "games/1"
end

And(/^I enter a guess$/) do
  fill_in('game[guess]', with: 'a')
end

Then(/^I click update game$/) do
  click_on('Submit')
end

And(/^I click on the back link$/) do
  click_link("Back")
end
