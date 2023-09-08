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

  def movements
    delta_movements = [[1,2],[2,1],[2,-1],[1,-2],[-1,-2],
    [-2,-1],[-2,1],[-1,2]]

    #The method to calculate the movement of the pice
    #according to the delta of movements is in the module.
    valid_movements = calculate_movements(position, delta_movements)
  end
end




knight1 = Knight.new([3,3], "black")
