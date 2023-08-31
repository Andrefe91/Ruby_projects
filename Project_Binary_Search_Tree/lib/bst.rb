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

class Tree
  attr_reader :array, :root
  def initialize(array)
    @array = array.uniq!
    @root = build_tree
  end

  def build_tree
    @root = Node.new(array[0])


    array[1..].each do |value|
      new_node = Node.new(value)
      existing_node = root

      #To traverse the nodes without recursion
      while true

        if new_node > existing_node
          if existing_node.right_child.nil?
            existing_node.right_child = new_node
            break
          else
            existing_node = existing_node.right_child
          end
        else
          if existing_node.left_child.nil?
            existing_node.left_child = new_node
            break
          else
            existing_node = existing_node.left_child
          end
        end

      end

    end
    @root
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end

  
end

test = Tree.new([1,7,4,23,9,8,4,3,5,7,9,67,6345,324])
#test = Tree.new(Array.new(15) {rand(1..100)})

test.pretty_print
