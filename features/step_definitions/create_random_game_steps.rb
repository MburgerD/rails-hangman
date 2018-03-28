Then(/^I should see a button to create a random game$/) do
  expect(page).to have_button("Create game with a random word")
end

And(/^I click the random game button$/) do
  click_button("Create game with a random word")
end
