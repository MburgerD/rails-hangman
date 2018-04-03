class Guess < ApplicationRecord
  belongs_to :game

  validates :letter, presence: true,
                     uniqueness: { scope: :game_id },
                     length: { maximum: 1 },
                     format: { with: /[a-zA-Z]/, message: "must be a letter" }
end
