# Implementation of the Tic-Tac-Toe game in Ruby for The Odin Project.

class Board
  def initialize
    @board = { 1 => 1, 2 => 2, 3 => 3, 4 => 4, 5 => 5, 6 => 6, 7 => 7, 8 => 8, 9 => 9 }
  end

  def play(coordinate, symbol)
    unless coordinate.to_int > 10
      @board[coordinate] = symbol
    end
  end

  def return_board
    @board.values
  end

  # Checks if the booard contains a winner by comparing symbols with the winning positions
  def win?
    win_array = [[1, 4, 7], [2, 5, 8], [3, 6, 9],
                 [1, 2, 3], [4, 5, 6], [7, 8, 9],
                 [1, 5, 9], [3, 5, 7]]

    win_array.each do |posibility|
      return true if @board[posibility[0]] == @board[posibility[1]] && @board[posibility[1]] == @board[posibility[2]]
    end
    false
  end
end

# Class Player defined with the two main characteristics
class Player
  @@player_number = 0

  attr_accessor :name, :symbol

  def initialize(name = "Player", symbol)
    @name = name
    @symbol = symbol
    @@player_number += 1
  end

  # Class methods for practice, not really useful
  def self.number_of_players
    @@player_number
  end
end

def pretty_print(object)
  values = object.return_board

  puts "\n"
  for i in 0..2 do
    print "#{values[3 * i]} | #{values[3 * i + 1]} | #{values[3 * i + 2]}\n"
    if i < 2
      print "--+--+--\n"
    end
  end
  puts "\n"
end

def game_start

  tablero = Board.new
  puts "--------------------------------"
  puts "Game Starts!!"
  puts "--------------------------------"
  print "Please Player 1, enter your name: "
  name = gets.chomp
  print "And now, your prefered Symbol: "
  symbol = gets.chomp
  player1 = Player.new(name, symbol)
  puts "--------------------------------"
  print "Please Player 2, enter your name: "
  name = gets.chomp
  print "And now, your prefered Symbol: "
  symbol = gets.chomp
  player2 = Player.new(name, symbol)
  puts "--------------------------------"
  puts "Ok, Lets Play !!!!!!"
  puts "--------------------------------"
  puts 'This is your board:'
  puts "\n"
  pretty_print(tablero)
  puts "\n"
  game(tablero, player1, player2)

end

def game(tablero, player1, player2)

  while true

    print "It's #{player1.name} turn, choose your position: "
    move = gets.chomp.to_i
    tablero.play(move, player1.symbol)
    pretty_print(tablero)
    break if tablero.win?

    print "It's #{player2.name} turn, choose your position: "
    move = gets.chomp.to_i
    tablero.play(move, player2.symbol)
    pretty_print(tablero)
    break if tablero.win?

  end


end
game_start
