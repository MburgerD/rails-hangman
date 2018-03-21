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
end
