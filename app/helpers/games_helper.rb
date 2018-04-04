module GamesHelper
  def masked_word(game)
    ''.tap do |revealed_letters|
      game.word.split('').each do |letter|
        if game.guesses_list.include? letter.downcase
          revealed_letters << letter
        else
          revealed_letters << '-'
        end
      end
    end
  end
end
