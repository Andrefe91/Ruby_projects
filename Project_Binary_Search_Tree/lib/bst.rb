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
    #This is a modified version of a BST, where the nodes also connect to their parents
    @parent = nil
  end

  def inspect
    "Node with value #{@value}"
    #"Node with value #{@value}, \n left child \n {#{@left_child.inspect}} \n right child \n {#{@right_child.inspect}}"
  end

end

class Tree
  attr_reader :array, :root, :size
  def initialize(array)
    @array = array.uniq
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
      elsif new_node == existing_node
        return
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
    if node == @root
      child = node.right_child
      while true
        unless child.left_child.nil?
          child =  child.left_child
        else
          break
        end
      end

      #Updating the connections in the tree:
      delete(child.value) #The node has to be deleted in order to avoid a circular tree
      child.left_child = root.left_child
      child.right_child = root.right_child
      child.parent = nil
      @root = child
      return #This helps to avoid overlap in checks
    end

    #For the case the node that holds the given value is a leaf node
    if node.left_child.nil? && node.right_child.nil?
      if parent.left_child == node
        parent.left_child = nil
      else
        parent.right_child = nil
      end
      return #This helps to avoid overlap in checks
    end

    #For the case the node that holds the given value only has one child
    if node.left_child.nil? || node.right_child.nil?
      child = (node.left_child || node.right_child)

      parent.left_child === node ? parent.left_child = child : parent.right_child = child

      child.parent = parent
      return #This helps to avoid overlap in checks
    end

    #For the case the node that holds the given value has two childs
    unless node.left_child.nil? && node.right_child.nil?
      child = node.right_child
      while true
        unless child.left_child.nil?
          child =  child.left_child
        else
          break
        end
      end

      delete(child.value) #The node has to be deleted in order to avoid a circular tree

      #Updating the connections in the tree:
      parent.left_child == node ? parent.left_child = child : parent.right_child = child
      child.parent = parent

      child.right_child = node.right_child
      child.left_child = node.left_child

      child.right_child.parent = child unless child.right_child.nil?
      child.left_child.parent = child unless child.left_child.nil?

      #No more cases, so no need for a break statement
    end

  end

  def each(&block)
    #Custom enumerable method for a level order traversal
    queue = [root]

    #Loop to traverse the BST
    while true
      return if queue.empty?

      yield(queue[0])

      #Add to queue the childs of the visited nodes only if they are not nil
      queue.append(queue[0].left_child) unless queue[0].left_child.nil?
      queue.append(queue[0].right_child) unless queue[0].right_child.nil?

      #Dequeue the first element in a First In, First Out kind of way
      queue.delete_at(0)
    end
  end

  def level_order(&block)
    array = []
    #Populate the array with the values of every node give by the enumerable
    if block_given?
      each do |element|
        block.call(element)
      end
    else
      #In order to be able to obtain the array when no block is given to Inorder, we pass a custom block
      #to the inorder enumerable method that append the value to an array. As such, this last method
      #must be able to recibe such a block, thats why it's added the &block to the enumerable method.
      each {|element| array << element.value}
      return array
    end
  end

  def preorder_each(node = @root, &block)
    #Custom enumerable method for a preorder tree traversal
    if node.nil?
      return
    end

    yield(node)
    preorder_each(node.left_child, &block)
    preorder_each(node.right_child, &block)
  end

  def postorder_each(node = @root, &block)
    #Custom enumerable method for a postorder tree traversal
    if node.nil?
      return
    end

    postorder_each(node.left_child, &block)
    postorder_each(node.right_child, &block)
    yield(node)
  end

  def inorder_each(node = @root, &block)
    #Custom enumerable method for a inorder tree traversal
    if node.nil?
      return
    end

    inorder_each(node.left_child, &block)
    yield(node)
    inorder_each(node.right_child, &block)
  end

  def preorder(&block)

    array = []
    #Populate the array with the values of every node give by the enumerable
    #
    if block_given?
      preorder_each do |element|
        block.call(element)
      end
    else
      #In order to be able to obtain the array when no block is given to Inorder, we pass a custom block
      #to the inorder enumerable method that append the value to an array. As such, this last method
      #must be able to recibe such a block, thats why it's added the &block to the enumerable method.
      preorder_each {|element| array << element.value}
      return array
    end
  end

  def inorder(&block)
    array = []
    #Populate the array with the values of every node give by the enumerable

    if block_given?
      inorder_each do |element|
        block.call(element)
      end
    else
      #In order to be able to obtain the array when no block is given to Inorder, we pass a custom block
      #to the inorder enumerable method that append the value to an array. As such, this last method
      #must be able to recibe such a block, thats why it's added the &block to the enumerable method.
      inorder_each {|element| array << element.value}
      return array
    end

  end

  def postorder(&block)

    array = []
    #Populate the array with the values of every node give by the enumerable

    if block_given?
      postorder_each do |element|
        block.call(element)
      end
    else
      #In order to be able to obtain the array when no block is given to Inorder, we pass a custom block
      #to the inorder enumerable method that append the value to an array. As such, this last method
      #must be able to recibe such a block, thats why it's added the &block to the enumerable method.
      postorder_each {|element| array << element.value}
      return array
    end
  end

  def depth(value)

    parents = [root]
    depth = 0

    #Loop to traverse the BST
    while true
      children = []

      while true
        break if parents.empty?

        return depth if parents[0].value == value

        #Add to "children" the childs of the visited nodes only if they are not nil
        children.append(parents[0].left_child) unless parents[0].left_child.nil?
        children.append(parents[0].right_child) unless parents[0].right_child.nil?

        #Dequeue the first element in a First In, First Out kind of way
        parents.delete_at(0)
      end

      parents = children
      #This condition exist we can get the depth of the tree with this same method
      return depth if (parents.empty? && value == "max")
      return nil if parents.empty?
      depth += 1
    end
  end

  def height(value)
    node = search(value)
    return nil if node.nil? #Dont continue if the node isnt on the tree

    node_depth = depth(value)

    parents = [node]
    depth = 0

    #Loop to traverse the BST - Same core logic as the depth method
    while true
      children = []

      while true
        break if parents.empty?

        #Add to "children" the childs of the visited nodes only if they are not nil
        children.append(parents[0].left_child) unless parents[0].left_child.nil?
        children.append(parents[0].right_child) unless parents[0].right_child.nil?

        #Dequeue the first element in a First In, First Out kind of way
        parents.delete_at(0)
      end

      parents = children
      return (depth) if parents.empty?
      depth += 1
    end
  end

  def balanced(node =root)
    return 0 if node.nil? #Base case for the recursive call

    left_subtree = balanced(node.left_child)
    return -1 if left_subtree == -1 #If found imbalance, the whole tree is inbalanced

    #Check balance of the right subtree
    right_subtree = balanced(node.right_child)
    return -1 if right_subtree == -1 #If found imbalance, the whole tree is inbalanced

    #Check for a difference no bigger than one between left and right subtree
    return -1 if ((left_subtree-right_subtree).abs > 1)

    return ([left_subtree, right_subtree].max + 1)
  end

  def balanced?
    balanced == -1 ? false : true
  end

  def rebalance
    inorder_values = inorder
    p inorder_values
    sorted = []
    queue = [inorder_values]

    while true
      break if queue.empty?

      if queue[0].length >= 3
        middle_index = (queue[0].length/2.0).floor
        sorted.append(queue[0][middle_index])
        queue.append(queue[0][..(middle_index-1)])
        queue.append(queue[0][(middle_index+1)..-1])
        queue.delete_at(0)
      else
        sorted.append(queue[0])
        queue.delete_at(0)
      end
    end

    return Tree.new(sorted.flatten)
  end

end

%%
test = Tree.new([1,7,4,2,23,9,8,4,3,5,7,9, 12, 13, 67,6345,324, 628])
#test = Tree.new([1,2,3,4,5,6,7,8,9])
#test = Tree.new(Array.new(15) {rand(1..100)})
test.pretty_print
puts "--------------------------------"
test.insert(11)
test.pretty_print
puts "--------------------------------"
test.delete(7)
test.pretty_print
puts "--------------------------------"
puts "#Level_order method with a block to print the node values:"
test.level_order {|node| puts node.value}
puts "--------------------------------"
puts "#Inorder_order method with a block to print the node values:"
test.inorder {|node| puts node.value}
puts "--------------------------------"
test.pretty_print
puts "--------------------------------"
p test.depth(4)
puts "--------------------------------"
p test.height(8)
puts "--------------------------------"
p test.balanced?
puts "--------------------------------"
test = test.rebalance
test.pretty_print
puts "--------------------------------"
p test.balanced?
%

excersice_tree = Tree.new((Array.new(15) { rand(1..100) }))
excersice_tree.pretty_print
puts "--------------------------------"
puts "The tree is balanced?: #{excersice_tree.balanced?}?"
puts "--------------------------------"
puts "#Level_order method with a block to print the node values:"
p excersice_tree.level_order
puts "--------------------------------"
puts "#Inorder method with a block to print the node values:"
p excersice_tree.inorder
puts "--------------------------------"
puts "#Preorder method with a block to print the node values:"
p excersice_tree.preorder
puts "--------------------------------"
puts "#Postorder method with a block to print the node values:"
p excersice_tree.postorder
puts "--------------------------------"
100.times do
  excersice_tree.insert(rand(1..100))
end
puts "Added 100 elements to the tree:"
excersice_tree.pretty_print
puts "--------------------------------"
puts "The tree is balanced?: #{excersice_tree.balanced?}"
puts "--------------------------------"
excersice_tree = excersice_tree.rebalance
excersice_tree.pretty_print
puts "--------------------------------"
puts "The tree is balanced?: #{excersice_tree.balanced?}"
puts "--------------------------------"
puts "#Inorder method with a block to print the node values:"
p excersice_tree.inorder
puts "--------------------------------"
puts "#Preorder method with a block to print the node values:"
p excersice_tree.preorder
puts "--------------------------------"
puts "#Postorder method with a block to print the node values:"
p excersice_tree.postorder
