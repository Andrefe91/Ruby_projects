class Hangman
  attr_reader :word, :guesses, :game_array, :used_letters

  def initialize (word, max_turns)
    @word = word
    @max_turns = max_turns
    @guesses = 0
    @used_letters = []
    @game_array = create_game_array(word)
  end

  def guess(letter)
    @guesses += 1
    add_letter(letter) if in_word?(letter) && @guesses <= @max_turns
    used_letters.push(letter) unless used_letters.include?(letter)
  end

  def word_length
    @word.length
  end

  def pretty_print
    "Turn: #{guesses} | #{@game_array.join(" ")}"
  end

  def in_word?(letter)
    @word.include?(letter)
  end

  def win?
    @word == @game_array.join("")
  end

  def over_turn?
    @guess >= @max_turns
  end

  private

  def create_game_array(word)
    Array.new(word.length, "_")
  end

  def add_letter(letter)
    @word.split("").each_with_index {|each, index| @game_array[index] = letter if each == letter}
    @game_array
  end
end
