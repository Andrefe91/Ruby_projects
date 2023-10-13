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
    print "Name of player 1: "
    @player1 = Player.new(gets.chomp)
    print "Name of player 2: "
    @player2 = Player.new(gets.chomp)
  end

  #Creating the loop for the game
  def game_loop
    require_players
    board.pretty_print
    until win? do
      player = turn
      call_player(player)
      add_to_column(player)
      board.pretty_print
    end
  end

  def win?
    board.win?
  end

  def call_player(player)
    puts "Ok #{player.name}, it's your turn!"
    print "Choose a Column: "
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

  def add_to_column(player)
    column = gets.chomp.to_i
    @board.add_to_column(column, player.token)
  end

end

#test = Game_four.new
#test.game_loop
