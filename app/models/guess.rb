class Guess < ApplicationRecord
  belongs_to :game

  validates :letter, presence: true,
                     uniqueness: { scope: :game_id },
                     length: { maximum: 1 },
                     format: { with: /[a-zA-Z]/, message: "must be a letter" }

  before_validation :downcase_guess, on: :create

  private

  def downcase_guess
    begin
      letter.downcase!
    rescue; end
  end
end
