#Ruby implementation of a Binary Search Tree data structure

class Node
  include Comparable
  attr_accessor :value, :left_child, :right_child, :parent

  def <=>(other)
    value <=> other.value
  end

  def initialize(value)
    @value = value
    @left_child = nil
    @right_child = nil
    #This is modified version of a BST, where de nodes also connect to their parent
    @parent = nil
  end

  def inspect
    "Node with value #{@value}, \n left child \n {#{@left_child.inspect}} \n right child \n {#{@right_child.inspect}}"
  end

end

class Tree
  attr_reader :array, :root, :size
  def initialize(array)
    @array = array.uniq!
    @root = build_tree
  end

  def build_tree
    @root = Node.new(array[0])

    #With the help of a method we can handle building the tree
    #and inserting nodes into it
    array[1..].each do |value|
      insert(value)
    end
    @root
  end

  def pretty_print(node = @root, prefix = '', is_left = true)

    #Pretty printing the tree with recursiononal indentation
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end

  def insert(value)
    new_node = Node.new(value)
    existing_node = root

    #Method used in construction/traversal, but just one loop for insertion. To avoid recursion, we use a single
    #while loop
    while true

      if new_node > existing_node
        if existing_node.right_child.nil?
          existing_node.right_child = new_node
          new_node.parent = existing_node
          break
        else
          existing_node = existing_node.right_child
        end
      else
        if existing_node.left_child.nil?
          existing_node.left_child = new_node
          new_node.parent = existing_node
          break
        else
          existing_node = existing_node.left_child
        end
      end
    end
  end

  def search(value)
    node = root

    #Traverse the tree searching for the node that holds the given value
    #and return it.
    #The rescue statement is to catch when the value is not found

    begin
      while true
        if node.nil?
          break
        elsif value > node.value
          node = node.right_child

        elsif value < node.value
          node = node.left_child

        elsif value == node.value
          return node
        end
      end

    rescue NoMethodError
      puts "Node not found"
      return nil
    end
  end

  def delete(value)
    node = search(value)

    if node.nil?
      puts "Node not found"
      return nil
    end

    parent = node.parent

    #For the case the node that holds the given value is the root node



    #For the case the node that holds the given value is a leaf node
    if node.left_child.nil? && node.right_child.nil?
      if parent.left_child.value == node.value
        parent.left_child = nil
      else
        parent.right_child = nil
      end
    end

    #For the case the node that holds the given value only has one child


    #For the case the node that holds the given value has two childs

  end

end

test = Tree.new([1,7,4,23,9,8,4,3,5,7,9,67,6345,324])
#test = Tree.new(Array.new(15) {rand(1..100)})
test.pretty_print

test.insert(11)
test.pretty_print


test.delete(324)
test.pretty_print
