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
end
