require 'rails_helper'

RSpec.describe "games/show", type: :view do
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
    it "done not render form" do
      @game.guesses << 'word'
      expect(@game.game_won?).to eq true
      render

      assert_select "form", :count => 0
    end

    it "displays game won message" do
      @game.guesses << 'word'
      expect(@game.game_won?).to eq true
      render

      expect(rendered).to match(/Well done, you won!/)
    end
  end

  context "game lost" do
    it "renders show game form" do
      @game.lives = 0
      expect(@game.game_lost?).to eq true
      render

      assert_select "form", :count => 0
    end

    it "displays game lost message" do
      @game.lives = 0
      expect(@game.game_lost?).to eq true
      render

      expect(rendered).to match(/Game lost!/)
    end
  end

end
