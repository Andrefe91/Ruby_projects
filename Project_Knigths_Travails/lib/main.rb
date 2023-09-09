# Ruby implementation of a decision tree for the knight movement (Chess piece)
require './chess_modules'

class Pieces
  @@number_of_pieces = 0
  attr_accessor :position, :state

  def initialize(position, color = "black")
    @position = position
    @color = color
    @state = 1 #Binary state, 1 for alive and 0 for dead
    @@number_of_pieces += 1
  end

  def self.number
    @@number_of_pieces
  end

end

class Knight < Pieces
  include Chess_methods

  attr_accessor :position, :state
  attr_reader :color

  def initialize(position, color = "black")
    super(position, color)
    #The valid movements are calculated for the position
    #every update to the position must update the valid
    #movements
    @valid_movements = movements
  end

  def movements
    delta_movements = [[1,2],[2,1],[2,-1],[1,-2],[-1,-2],
    [-2,-1],[-2,1],[-1,2]]

    #The method to calculate the movement of the pice
    #according to the delta of movements is in the module.
    calculate_movements(position, delta_movements)
  end

  def valid_movements
    @valid_movements = movements
  end
end

class Node
  attr_reader :childs, :position
  def initialize(chess_piece,
    parent = nil,
    position = chess_piece.position
    )
    @chess_piece = chess_piece
    @chess_piece.position = position
    @color = @chess_piece.color
    @position = position
    @valid_movements = @chess_piece.valid_movements
    @parent = nil
    @childs = nil
    @child_array = nil
  end

  def add_childrens
    array = []
    @valid_movements.each do |movement|
      array << Node.new(@chess_piece, movement)
    end

    @childs = array
    @child_array = @valid_movements
  end

  def inspect
    "Node of a #{@chess_piece.class} with properties ->
    position: #{@position},
    color: #{@color},
    valid movements: #{@valid_movements},
    parent: #{
      @parent.nil? ? "nil" : @parent
    } and
    childs: #{
      @childs.nil? ? "nil" : @child_array
    } \n"
  end
end

class Tree
  attr_reader :root

  def initialize(chess_piece)
    @root = Node.new(chess_piece)
    @depth = 0
  end

  

end


knight1 = Knight.new([0,0])
knight1.movements
p knight1.position
p knight1.color
p knight1.valid_movements
knight1.position = [1,7]
p knight1.valid_movements
test = Node.new(knight1)
puts "--------------------------------------"
p test
