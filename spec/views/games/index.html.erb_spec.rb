require 'rails_helper'

describe "games/index" do
  before(:each) do
    game1 = Game.create!(:word => "Word", :lives => 2)
    game2 = Game.create!(:word => "Word", :lives => 2)
    game1.guesses.create letter: 'w'
    game2.guesses.create letter: 'w'
    assign(:games, [game1, game2])
  end

  it "renders a list of games" do
    render
    assert_select "tr>td", :text => "W---".to_s, :count => 2
    assert_select "tr>td", :text => "w".to_s, :count => 2
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
