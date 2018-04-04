class RandomWordGenerator
  def self.generate_word
    chosen_word = nil
    File.foreach(DICT_PATH).each_with_index do |line, number|
      chosen_word = line if rand < 1.0 / (number + 1)
    end
    chosen_word.chomp
  end

  private

  DICT_PATH = '/usr/share/dict/words'.freeze
end
