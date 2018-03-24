class Game < ApplicationRecord
  attr_accessor :guess

  validates :word, presence: true,
                   length: { maximum: 20 },
                   format: { with: /\A[a-zA-Z]+\z/ }
  validates :lives, numericality: { only_integer: true,
                                    less_than_or_equal_to: 10,
                                    greater_than: 0 }
  validates :guess, presence: true, on: :update,
                    length: { maximum: 1 },
                    format: { with: /[a-zA-Z]/, message: "must be a letter" }

  def add_guess(letter)
    update guesses: guesses + letter
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
end
