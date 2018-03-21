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

  context "with guesses not present on update" do
    it "does not update the game" do
      subject
      expect(game.update(guesses: '')).to be false
    end
  end

  context "with guesses of more than one letter on update" do
    it "does not update the game" do
      subject
      expect(game.update(guesses: 'aaa')).to be false
    end
  end

  context "with number submitted to guesses on update" do
    it "does not update the game" do
      subject
      expect(game.update(guesses: 1)).to be false
    end
  end

  context "with symbol submitted to guesses on update" do
    it "does not update the game" do
      subject
      expect(game.update(guesses: '!')).to be false
    end
  end

  context "with single letter submitted to guesses on update" do
    it "updates the game" do
      subject
      expect(game.update(guesses: 'a')).to be true
      expect(game.guesses).to eq 'a'
    end
  end

  context "with two guesses submitted" do
    it "stores both letters in guesses" do
      subject
      game.update(guesses: 'a')
      game.update(guesses: 'b')

      expect(game.guesses).to eq 'ab'
    end
  end
end
