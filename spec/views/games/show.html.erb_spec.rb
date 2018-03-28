require 'rails_helper'

describe "games/show" do
  before(:each) do
    @game = assign(:game, Game.create!(
                            :word => "Word",
                            :guesses => "r",
                            :lives => 2
    ))
  end

  it "shows only letters in the word which have been guessed" do
    render
    expect(rendered).to match(/--r-/)
  end

  context "game not won or lost" do
    it "renders show game form" do
      expect(@game.game_over?).to eq false
      render

      assert_select "form[action=?][method=?]", "/games/#{@game.id}", "post" do
        assert_select "input[name=?]", "game[guess]"
      end
    end
  end

  context "game won" do
    it "does not render form" do
      @game.guesses << 'word'
      expect(@game.game_won?).to eq true
      render

      assert_select "form", :count => 0
    end
  end

  context "game lost" do
    it "does not render form" do
      @game.lives = 0
      expect(@game.game_lost?).to eq true
      render

      assert_select "form", :count => 0
    end
  end

end
