require_relative '../lib/player'
require_relative '../lib/board'

class Game_four
  attr_reader :player1, :player2

  def initialize
    @board = Board.new
    @player1 = nil
    @player2 = nil
  end

  #Main logic for the game, connecting all functions and classes
  def play

  end

  #Asking the players for their names and creating the player objects
  def require_players
    puts "Name of player 1: "
    @player1 = Player.new(gets.chomp)
    puts "Name of player 2: "
    @player2 = Player.new(gets.chomp)
  end

  #Creating the loop for the plays
  def game_loop

  end


end
