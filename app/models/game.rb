class Game < ApplicationRecord
  has_many :guesses, dependent: :destroy

  validates :word, presence: true,
                   length: { maximum: 20 },
                   format: { with: /\A[a-zA-Z]+\z/ }
  validates :lives, numericality: { only_integer: true,
                                    less_than_or_equal_to: 10,
                                    greater_than: 0 }

  def guesses_list
    guesses.map(&:letter)
  end

  def remaining_lives
    lives - guesses.length + correct_guesses.length
  end

  def game_over?
    game_won? || game_lost?
  end

  def game_lost?
    remaining_lives.zero?
  end

  def game_won?
    all_letters_guessed?
  end

  def letter_in_word?(letter)
    word.downcase.include? letter
  end

  private

  def correct_guesses
    word.downcase.split('').uniq & guesses_list
  end

  def all_letters_guessed?
    (word.downcase.chars - correct_guesses).empty?
  end
end
