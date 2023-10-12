require_relative '../lib/player'
require_relative '../lib/board'

class Game_four
  attr_reader :player1, :player2, :board

  def initialize
    @board = Board.new
    @player1 = nil
    @player2 = nil
    @turn = 0
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

  #Creating the loop for the game
  def game_loop
    until win? do
      player = turn
      call_player(player)
      
    end
  end

  def win?
    board.win?
  end

  def call_player(player)
    puts "Ok Player #{player.number}, it's your turn!"
    puts "Choose a Column:"
  end

  def turn
    if @turn == 0
      @turn = 1
      return @player1
    else
      @turn = 0
      return @player2
    end
  end

end
