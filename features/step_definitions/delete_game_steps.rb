And(/^I should see links to delete the games$/) do
  have_link("Destroy", count: 2)
end

And(/^I click on the delete link of the top game$/) do
  within "tbody" do
    first("tr").click_link("Destroy")
  end
end

When(/^The game should be gone$/) do
  within "tbody" do
    expect(page).to have_css("tr", count: 1)
  end
end
