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

  def rebalance
    inorder_values = [1,1,2,3,4,5,6,7,8]

    test = Tree.new(inorder_values)
  end

end
