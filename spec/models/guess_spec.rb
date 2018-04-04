require 'rails_helper'

describe Guess do
  let(:game) { Game.new word: 'foo', lives: 5 }
  describe "validation" do
    context "with no guess entered" do
      it "does not save the guess" do
        guess = Guess.new game: game
        expect(guess.save).to be false
      end
    end

    context "with a number given for guess.letter" do
      it "does not save the guess" do
        guess = Guess.new game: game, letter: 1
        expect(guess.save).to be false
      end
    end

    context "with more than one letter entered" do
      it "does not save the guess" do
        guess = Guess.new game: game, letter: 'bar'
        expect(guess.save).to be false
      end
    end

    context "with the same letter as an existing guess" do
      it "does not save the guess" do
        Guess.create game: game, letter: 'a'
        guess = Guess.new game: game, letter: 'a'
        expect(guess.save).to be false
      end
    end

    context "with one letter entered" do
      it "saves the guess" do
        guess = Guess.new game: game, letter: 'a'
        expect(guess.save).to be true
      end
    end
  end

  describe "on guess creation" do
    it "converts the guess to lowercase" do
      Guess.create game: game, letter: 'A'
      expect(Guess.last.letter).to eq 'a'
    end
  end
end
