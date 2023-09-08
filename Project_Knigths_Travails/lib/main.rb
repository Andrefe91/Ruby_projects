# Ruby implementation of a decision tree for the knight movement (Chess piece)
require './chess_modules'

class Pieces
  @@number_of_pieces = 0
  attr_accessor :position, :state

  def initialize(position, color)
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

  def initialize(position, color)
    super(position, color)
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




knight1 = Knight.new([0,0], "black")
knight1.movements
p knight1.position
p knight1.color
p knight1.valid_movements
knight1.position = [1,7]
p knight1.valid_movements
