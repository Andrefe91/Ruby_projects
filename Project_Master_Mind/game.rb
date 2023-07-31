require './objects.rb'

class Game
  attr_accessor :role

  def initialize (role)
    @role = role
  end

  def valid_guess?(guess)
    check = true

    return false unless guess.length == 4

    guess.split('').each do |number|
      (check = false) unless number.to_i.between?(1,6)
    end

    check
  end

end


def ask_guess (game_object)
  print "Please, enter your guess: "
  guess = gets.chomp
  #puts "[Debug] - Guess is #{guess}"

  if game_object.valid_guess?(guess)
    return guess
  else
    print_error ("guess")
    ask_guess (game_object)
  end

end

def ask_code (game_object)
  print "Please, enter the code for the Computer to crack: "
  code = gets.chomp
  puts '------------------------------------------------------'

  if game_object.valid_guess?(code)
    return code
  else
    print_error ("code")
    ask_code (game_object)
  end
end

def player_selection
  puts '1 - Code Maker'
  puts '2 - Code Cracker'

  print 'Whats your selected role?: '
  selection = gets.chomp

  if selection == '1'
    return 'Maker'
  elsif selection == '2'
    return 'Cracker'
  else
    print_error ("option")
    player_selection
  end

end

def print_error (word)
  puts "\n"
  puts '-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-'
  puts "Sorry, invalid #{word}. Try again"
  puts '-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-'
  puts "\n"
end

#Method to create a list with all posssible patterns that match
#the key pegs of the guess used by minimax
def key_pegs_minimax (guess, pattern_list, last_key_pegs)

  temporal_board = Board.new(guess)

  pattern_list.reject! do |pattern|
    temporal_board.key_pegs(pattern.chars.map(&:to_i)) != last_key_pegs
  end

  pattern_list
end

def minimax (guesses_left, possibilities)

  max_count_of_guesses = guesses_left.map do |guess|

    #For the array of possible patterns calculated in the last iteration,
    # calculate with one of the guesses left the number of possible matches
    #in that array. That way, we can maximize the number of possible eliminations
    #for the possible patterns.
    guesses_hit_list = possibilities.each_with_object(Hash.new(0)) do |possible_guess, counts|

      temporal_board = Board.new(guess)
      counts[temporal_board.key_pegs(possible_guess.chars.map(&:to_i))] += 1
    end

    max_number_of_possibilities = guesses_hit_list.values.max || 0
    included = possibilities.include?(guess)

    included ? [max_number_of_possibilities, guess]:nil

  end

  max_count_of_guesses.delete(nil)
  max_count_of_guesses.min.last
end
