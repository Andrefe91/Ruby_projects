#Linked list implementation in ruby for The Odin Project

class Node
  attr_accessor :value, :next_node, :prev_node

  def initialize(value)
    @value = value
    @next_node = nil
    @prev_node = nil
  end
end

class LinkedList
  def initialize
    @head = nil
    @tail = nil
    @size = 0
  end

  def head
    @head
  end

  def tail
    @tail
  end

  def size
    @size
  end

  def new_node(value)
    #To mantain order, we separete the Node creation method
    #from Node manipulation methods
    @size += 1
    Node.new(value)
  end

  def prepend(value)
    node = new_node(value)

    #If the list is empty, then head and tail will be the same node
    if @head.nil?
      @head = node
      @tail = node
    else
      #Because we are prepending, we use the head of the list to setup the reference
      #for the next node (we first copy the memory direction of the node head)
      node.next_node = @head
      @head.prev_node = node

      #And then, we append the new node to the head
      @head = node
    end
  end

  def append(value)
    node = new_node(value)

    #If the list is empty, then head and tail will be the same node
    if @head.nil?
      @head = node
      @tail = node
    else
      #Because we are appending, we use the head of the list to setup the reference
      #for the next node (we first copy the memory direction of the node tail)
      @tail.next_node = node
      node.prev_node = @tail


      #And then, we append the new node to the head
      @tail = node
    end
  end

  def to_s
    node = @head

    if @size <= 0
      puts '()'
      return nil
    end

    #Simple loop to traverse the list and print the values of each node
    while true
      print "( #{node.value} ) -> "

      if node.next_node.nil?
        print "nil"
        break
      else
        node = node.next_node
      end
    end
    #Format is important
    print "\n"
  end

  def at(position)

    #If position is negative, the values are seek from the tail position
    (position = @size + position) if position < 0

    #If index is bigger than the linked list size
    return nil if (position+1 > @size || position < 0)

    #start from the head
    node = @head

    #and then traverse the list
    position.times do
      node = node.next_node
    end

    #and then return value
    node.value
  end

  def pop

    if @size <= 0
      @head = nil
      @tail = nil
    else
      #First capture the memory direction of the node previously to tail
      #then reset the 'next_node' direction of such node and move tail pointer
      node = @tail.prev_node
      @size -= 1

      node.next_node = nil

      @tail = node
    end
  end

  def contains?(value)
    node = @head

    #Traverse the list looking for the value on the nodes
    while true

      (return true) if node.value === value

      (node.next_node.nil?) ? break : node = node.next_node

    end

    #if not found:
    false
  end

  def find(value)
    node = @head
    index = 0

    #Traverse the list looking for the value on the nodes
    while true

      (return index) if node.value === value

      (node.next_node.nil?) ? break : node = node.next_node

      index += 1
    end

    #if not found:
    nil
  end

  def insert_at(value, index)

    if index == 0
      prepend(value)
    elsif index == (@size-1)
      append(value)
    else
      new_node = Node.new(value)
      node = @head

      #Traverse the list up to node at index
      (index-1).times do
        node = node.next_node
      end

      before = node
      after = node.next_node

      #Update the relative links of the tree nodes

      before.next_node = new_node
      after.prev_node = new_node

      new_node.prev_node = before
      new_node.next_node = after
    end

  end

end

test = LinkedList.new

puts "Empty list:"
test.to_s

test.append(1)
test.append(2)
test.append(3)
test.append(4)
test.append(5)
test.prepend('text')

puts "Simple defined list:"
test.to_s
puts "Size of linked list is: #{test.size}"

puts "List after a pop operation:"
test.pop

test.to_s

print "The list contains the number 5?: "
p test.contains?(5)

puts "The value at a given (0) index is: #{test.at(0)}"

print "The index for the search value (4) is: "
p test.find(4)

print "The index for the search value (text) is: "
puts test.find('text')

test.insert_at('insert', 3)

puts "Inserting the node 'test' at index 3 gets us this linked list:"
test.to_s

#The at(value) method needs work to return nil when index is negative and bigger than size
