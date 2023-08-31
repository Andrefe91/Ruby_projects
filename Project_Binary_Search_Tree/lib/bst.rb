#Ruby implementation of a Binary Search Tree data structure

class Node
  include Comparable
  attr_accessor :value, :left_child, :right_child

  def <=>(other)
    value <=> other.value
  end

  def initialize(value)
    @value = value
    @left_child = nil
    @right_child = nil
  end

  def inspect
    "Node with value #{@value}"
  end

end

node1 = Node.new(1)

