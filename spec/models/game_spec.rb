require 'rails_helper'

describe Game do
  describe "validation on Game creation" do
    let(:word) { "example" }
    let(:lives) { 5 }
    let(:game) { Game.new(word: word, lives: lives) }

    context "with no word entered" do
      let(:word) { "" }

      it "the game is not valid" do
        expect(game).not_to be_valid
      end
    end

    context "with word of length > 20" do
      let(:word) { "a" * 21 }

      it "the game is not valid" do
        expect(game).not_to be_valid
      end
    end

    context "with word containing numbers" do
      let(:word) { "ab3a" }

      it "the game is not valid" do
        expect(game).not_to be_valid
      end
    end

    context "with word containing symbols" do
      let(:word) { "ab@a" }

      it "the game is not valid" do
        expect(game).not_to be_valid
      end
    end

    context "with word of only letters and length 1..20" do
      let(:word) { "a" * 10 }

      it "the game is valid" do
        expect(game).to be_valid
      end
    end

    context "with lives = 0" do
      let(:lives) { 0 }

      it "the game is not valid" do
        expect(game).not_to be_valid
      end
    end

    context "with lives > 10" do
      let(:lives) { 11 }

      it "the game is not valid" do
        expect(game).not_to be_valid
      end
    end

    context "with lives in range 1..10" do
      let(:lives) { 7 }

      it "the game is valid" do
        expect(game).to be_valid
      end
    end
  end

  describe "#remaining_lives" do
    let(:game) { Game.create word: 'foo', lives: 5 }

    context "given a game with 5 lives" do
      context "with correct letter guessed" do
        it "has 5 lives remaining" do
          game.guesses.create! letter: 'f'

          expect(game.remaining_lives).to eq 5
        end
      end

      context "with an incorrect letter guessed" do
        it "has 4 lives remaining" do
          game.guesses.create! letter: 'z'

          expect(game.remaining_lives).to eq 4
        end
      end
    end
  end

  describe "#guesses_list" do
    let(:game) { Game.create word: 'foo', lives: 5 }
    before(:each) do
      game.guesses.create! letter: 'a'
      game.guesses.create! letter: 'b'
    end

    context "with two existing guesses" do
      it "returns a list of the letters of the guesses" do
        expect(game.guesses_list).to eq ['a', 'b']
      end
    end
  end
end
