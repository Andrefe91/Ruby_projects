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

  #Asking the players for their names and creating the player objects
  def require_players
    print "Name of player 1: "
    @player1 = Player.new(gets.chomp)
    print "Name of player 2: "
    @player2 = Player.new(gets.chomp)
  end

  #Creating the loop for the game and the main logic, connecting all functions
  #and classes in the script
  def game_loop
    require_players
    board.pretty_print
    until win? do
      player = turn
      call_player(player)
      add_token(player)
      board.pretty_print
    end

    call_winner(player)
  end

  def win?
    board.win
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

  def add_token(player)
    while true
      column = gets.chomp.to_i
      break if valid_selection?(column)
      error_message
    end
    @board.add_to_column(column, player.token)
  end

  def valid_selection?(column)
    #Check if column is full, if so, then it's not a valid selection
    board.column_full?(column) ? (return false) : (return true)

    #Check if the column's number is valid per game rules
    column.between?(1,7) ? (return true) : (return false)
  end

  def error_message
    puts "xxx -> Error - Column number not valid <- xxx"
    print "Choose another column: "
  end

  def call_winner(player)
    puts "Congratulations #{player.name}, you WON the game !!"
  end

end

#test = Game_four.new
#test.game_loop
