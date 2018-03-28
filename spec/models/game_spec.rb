require 'rails_helper'

describe Game do
  describe "#save" do
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

  describe "#update" do
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

    context "with an already guessed letter" do
      it "does not update the game (failed validation)" do
        subject
        game.add_guess('a')

        expect(game.update(guess: 'a')).to be false
      end
    end
  end

  describe "#add_guess" do
    context "#add_guess called twice" do
      it "stores both args in guesses" do
        game = Game.new word: 'foo', lives: 5
        game.add_guess('a')
        game.add_guess('b')

        expect(game.guesses).to eq 'ab'
      end
    end

    context "called with capital letter" do
      it "stores downcase letter in guesses" do
        game = Game.new word: 'foo', lives: 5
        game.add_guess('A')

        expect(game.guesses).to eq 'a'
      end
    end
  end

  describe "#guessed_word" do
    context "no correct letters guessed" do
      it "displays only dashes" do
        game = Game.new word: 'fOo', lives: 5
        game.add_guess('a')
        game.add_guess('b')

        expect(game.guessed_word).to eq '---'
      end
    end

    context "correct letters guessed" do
      it "displays guessed letters" do
        game = Game.new word: 'fOo', lives: 5
        game.add_guess('a')
        game.add_guess('o')

        expect(game.guessed_word).to eq '-Oo'
      end
    end
  end

  describe "#update_lives?" do
    let(:game) { Game.new word: 'foo', lives: 5 }
    context "with correct letter guessed" do
      it "does not deduct a life" do
        game.update(guess: 'f')
        game.update_lives?

        expect(game.lives).to eq 5
      end
    end

    context "with incorrect letter guessed" do
      it "deducts a life" do
        game.update(guess: 'z')
        game.update_lives?

        expect(game.lives).to eq 4
      end
    end
  end

  describe "#random_word" do
    let(:game) { Game.new word: 'foo', lives: 5 }
    it "returns a string" do
      expect(game.random_word.class).to eq String
    end
  end
end
