require 'rails_helper'

describe "games/index" do
  before(:each) do
    assign(:games, [
      Game.create!(
        :word => "Word",
        :guesses => "wr",
        :lives => 2
      ),
      Game.create!(
        :word => "Word",
        :guesses => "wr",
        :lives => 2
      )
    ])
  end

  it "renders a list of games" do
    render
    assert_select "tr>td", :text => "W-r-".to_s, :count => 2
    assert_select "tr>td", :text => "wr".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end

  it "renders custom game button" do
    render
    expect(rendered).to include "Create a custom game"
  end

  it "renders random word button" do
    render
    expect(rendered).to include "Create game with a random word"
  end
end
