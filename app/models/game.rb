class Game < ApplicationRecord
  attr_accessor :guess

  validates :word, presence: true,
                   length: { maximum: 20 },
                   format: { with: /\A[a-zA-Z]+\z/ }
  validates :lives, numericality: { only_integer: true,
                                    less_than_or_equal_to: 10,
                                    greater_than: 0 }
  validates :guess, on: :update,
                    presence: true,
                    length: { maximum: 1 },
                    format: { with: /[a-zA-Z]/, message: "must be a letter" },
                    guess: true

  def add_guess(letter)
    update_attribute :guesses, guesses + letter.downcase
  end

  def guessed_word
    ''.tap do |revealed_letters|
      word.split('').each do |letter|
        if guesses.include? letter.downcase
          revealed_letters << letter
        else
          revealed_letters << '-'
        end
      end
    end
  end

  def update_lives?
    deduct_life unless letter_in_word?
  end

  def game_over?
    game_won? || game_lost?
  end

  def game_lost?
    lives.zero?
  end

  def game_won?
    all_letters_guessed?
  end

  def random_word
    chosen_word = nil
    File.foreach(DICT_PATH).each_with_index do |line, number|
      chosen_word = line if rand < 1.0 / (number + 1)
    end
    chosen_word.chomp
  end

  private

  DICT_PATH = '/usr/share/dict/words'.freeze

  def letter_in_word?
    word.downcase.include? guess
  end

  def deduct_life
    update_attribute :lives, lives - 1
  end

  def correct_letters
    word.downcase.split('').uniq & guesses.split('')
  end

  def all_letters_guessed?
    word.downcase.split('').uniq.length == correct_letters.uniq.length
  end
end
