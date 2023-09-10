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
  attr_accessor :parent, :childs, :child_array
  attr_reader :position, :valid_movements
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
  attr_reader :root, :last_level_nodes, :depth

  def initialize(chess_piece)
    @root = Node.new(chess_piece)
    @depth = 0
    @last_level_nodes = [@root]
  end

  def add_childrens(node = @root)
    array = []
    valid_movements = node.valid_movements

    valid_movements.each do |movement|
      child = Node.new(Knight.new(movement))
      child.parent = node

      array << child
    end

    node.childs = array
    node.child_array = valid_movements
  end

  def print_tree
    #Using a Breadth-first traversal we print the tree
    node = @root
    queue = [node]
    children = []

    while true
      break if queue.empty?

      queue.each do |node|
        node == " <> " ? (print " <> ") : (print node.position)

        next if node == " <> "

        unless node.childs.nil?
          node.childs.each do |child|
            children << child
          end
          children.append(" <> ")
        end
      end

      puts "\n ------ \n"
      queue = children
      children = []
    end
  end

  def increase_depth
    # Go trough each and every last node in the tree and
    # add childrens to them. Each node can process and add their own
    # children
    @depth += 1
    new_last_level_nodes = []

    @last_level_nodes.each do |node|
      add_childrens(node)

      node.childs.each do |child|
        new_last_level_nodes << child
      end
    end

    @last_level_nodes = new_last_level_nodes
  end

  def search_path(goal)
    path = []
    node_goal = search_node(goal)

    while true
      path << node_goal.position

      break if node_goal.parent.nil?

      node_goal = node_goal.parent

    end

    path = path.reverse
  end

  def search_node(goal)
    # Increase the depth of the tree if in a level cant find
    # the goal.

    while true
      @last_level_nodes.each do |node|
        return node if node.position == goal
      end
      increase_depth
    end
  end
end


def knight_moves(start, goal)
  tree = Tree.new(Knight.new(start))
  print_path(tree.search_path(goal), tree.depth)
end

def print_path(path, depth)

  puts "You made it in #{depth} moves. Here's your path:"

  path.each do |position|
    p position
  end
end

puts "--------------------------------------"

knight_moves([3,3],[0,0])

#output is:
#
#You made it in 2 moves. Here's your path:
#
#[3, 3]
#[2, 1]
#[0, 0]
