require 'rails_helper'

describe Game do
  describe "validation on Game creation" do
    context "with no word entered" do
      it "does not save the game" do
        game = Game.new
        expect(game.save).to be false
      end
    end

    context "with word of length > 20" do
      it "does not save the game" do
        word = 'a' * 21
        game = Game.new word: word
        expect(game.save).to be false
      end
    end

    context "with word containing numbers" do
      it "does not save the game" do
        word = 'ab3a'
        game = Game.new word: word
        expect(game.save).to be false
      end
    end

    context "with word containing symbols" do
      it "does not save the game" do
        word = 'ab@a'
        game = Game.new word: word
        expect(game.save).to be false
      end
    end

    context "with word of only letters and length 1..20" do
      it "saves the game" do
        word = 'a' * 10
        game = Game.new word: word
        expect(game.save).to be true
      end
    end

    context "with lives = 0" do
      it "does not save the game" do
        word = 'a' * 10
        game = Game.new word: word, lives: 0
        expect(game.save).to be false
      end
    end

    context "with lives > 10" do
      it "does not save the game" do
        word = 'a' * 10
        game = Game.new word: word, lives: 11
        expect(game.save).to be false
      end
    end

    context "with lives in range 1..10" do
      it "saves the game" do
        word = 'a' * 10
        game = Game.new word: word, lives: 7
        expect(game.save).to be true
      end
    end
  end

  describe "#remaining_lives" do
    let(:game) { Game.create word: 'foo', lives: 5 }
    context "with correct letter guessed" do
      it "has all lives" do
        game.guesses.create letter: 'f'

        expect(game.remaining_lives).to eq 5
      end
    end

    context "with incorrect letter guessed" do
      it "has one less life" do
        game.guesses.create letter: 'z'

        expect(game.remaining_lives).to eq 4
      end
    end
  end

  describe "#guesses_list" do
    let(:game) { Game.create word: 'foo', lives: 5 }
    before(:each) do
      game.guesses.create letter: 'a'
      game.guesses.create letter: 'b'
    end

    context "with two existing guesses" do
      it "returns a list of the letters of the guesses" do
        expect(game.guesses_list).to eq ['a', 'b']
      end
    end
  end
end
