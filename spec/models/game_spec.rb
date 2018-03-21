require 'rails_helper'

RSpec.describe Game, type: :model do
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

  let(:game) { Game.new word: 'foo', lives: 5 }
  subject { game.save }

  context "with guess not present on update" do
    it "does not update the game (failed validation)" do
      subject
      expect(game.update(guess: '')).to be false
    end
  end

  context "with guess of more than one letter on update" do
    it "does not update the game (failed validation)" do
      subject
      expect(game.update(guess: 'aaa')).to be false
    end
  end

  context "with a number guessed" do
    it "does not update the game (failed validation)" do
      subject
      expect(game.update(guess: 1)).to be false
    end
  end

  context "with a symbol guessed" do
    it "does not update the game (failed validation)" do
      subject
      expect(game.update(guess: '!')).to be false
    end
  end

  context "with a single letter guessed" do
    it "updates the game (passes validation)" do
      subject
      expect(game.update(guess: 'a')).to be true
      expect(game.guess).to eq 'a'
    end
  end

  context "with two guesses submitted" do
    it "updates the value of guess" do
      subject
      game.update(guess: 'a')
      game.update(guess: 'b')

      expect(game.guess).to eq 'b'
    end
  end

  context "#add_guess called twice" do
    it "stores both args in guesses" do
      subject
      game.add_guess('a')
      game.add_guess('b')

      expect(game.guesses).to eq 'ab'
    end
  end
end
