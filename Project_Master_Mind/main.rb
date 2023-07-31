require './objects.rb'
require './game.rb'
require 'pry-byebug'


def start

  puts '---------------------------------------------------------'
  puts 'Welcome to Master Mind, a Ruby implementation on console'
  puts '---------------------------------------------------------'
  puts 'First, Choose and option:'
  role = player_selection
  puts '-----------------------------------'
  puts "Alright Code #{role}, time to play"
  game_object = Game.new(role)


  #Implementation for the two game modes, for the moment, just the Human Player (Code Cracker Mode)

  #Calling the Code Cracker Mode
  code_cracker_mode (game_object) if role == 'Cracker'

  #Calling the Code Maker Mode
  code_maker_mode (game_object) if role == 'Maker'



end

def code_cracker_mode (game_object)
  board = Board.new
  #p "[Debug] Code: #{board.code}"
  puts "The computer decided on a code. Try to crack it !!"
  puts '---------------------------------------------------'

  while (board.full? == false && board.win? == false)
    #p "[Debug] Full: #{board.full?} and Win Condition: #{board.win?}"
    guess = ask_guess (game_object)
    board.use_guess (guess)
    board.pretty_print
  end

  if board.win? == true
    puts '-----------------------------------------------------------'
    puts "Congratulations, you cracked the code and won the game !!!"
    puts '-----------------------------------------------------------'
  else
    puts '-------------------------------------------------------'
    puts "The code you were looking for was: #{board.code}"
    puts "Sorry, you couldn't crack the code and lost the game "
    puts '-------------------------------------------------------'
  end
end

def code_maker_mode (game_object)

  code = ask_code(game_object)
  board = Board.new(code)

  all_possible_patterns = "123456".chars.product(*[["1","2","3","4","5","6"]]*3).map(&:join)
  guesses_left = all_possible_patterns

  guess = '1122'

  while true
    puts "The computer chose: #{guess}"
    guesses_left.delete(guess)
    board.use_guess(guess)
    board.pretty_print


    possibilities = key_pegs_minimax(guess, all_possible_patterns.dup, board.return_last_pegs)

    puts 'The Computer broke your code :P' if board.return_last_pegs == ['@', '@', '@', '@']
    break if board.return_last_pegs == ['@', '@', '@', '@']
    guess = minimax(guesses_left, possibilities)

  end
end


start
