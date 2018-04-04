require 'rails_helper'

describe GamesHelper do
  describe "#masked_word" do
    let(:game) { Game.create word: 'fOo', lives: 5 }

    context "no correct letters guessed" do
      it "displays only dashes" do
        game.guesses.create letter: 'a'
        game.guesses.create letter: 'b'

        expect(helper.masked_word(game)).to eq '---'
      end
    end

    context "correct letters guessed" do
      it "displays guessed letters" do
        game.guesses.create letter: 'a'
        game.guesses.create letter: 'o'

        expect(helper.masked_word(game)).to eq '-Oo'
      end
    end
  end
end
