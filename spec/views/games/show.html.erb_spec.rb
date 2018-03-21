require 'rails_helper'

RSpec.describe "games/show", type: :view do
  before(:each) do
    @game = assign(:game, Game.create!(
                            :word => "Word",
                            :guesses => "r",
                            :lives => 2
    ))
  end

  it "renders show game form" do
    render

    assert_select "form[action=?][method=?]", "/games/#{@game.id}", "post" do
      assert_select "input[name=?]", "game[guess]"
    end
  end

  it "shows only letters in the word which have been guessed" do
    render
    expect(rendered).to match(/--r-/)
  end
end
