# Implementation of the Tic-Tac-Toe game in Ruby for The Odin Project.

class Board

  def initialize()
    @board = {1 => 1,2 => 2,3 =>3, 4=>4, 5=>5, 6=>6, 7=>7, 8=>8, 9=>9}
  end

  def play(coordinate, symbol)
    unless coordinate.to_int > 10
      @board[coordinate] = symbol
    end
  end

  def return_board
    @board.values
  end

end

# Class Player defined with the two main characteristics
class Player
  @@player_number = 0

  attr_accessor :name, :symbol

  def initialize (name = "Player", symbol)
    @name = name
    @symbol = symbol
    @@player_number += 1
  end

  # Class methods for practice, not really useful
  def self.number_of_players ()
    @@player_number
  end

end

def pretty_print(object)

  values = object.return_board

  for i in 0..2 do
    print "#{values[3*i]} | #{values[3*i+1]} | #{values[3*i+2]}\n"
    if i < 2
      print "--+--+--\n"
    end
  end
end


tablero = Board.new()
pretty_print(tablero)
print "\n"
tablero.play(3, "X")
pretty_print(tablero)
print "\n"
tablero.play(5, "O")
pretty_print(tablero)
print "\n"
tablero.play(11, "X")
pretty_print(tablero)
