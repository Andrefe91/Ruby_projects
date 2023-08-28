#Linked list implementation in ruby for The Odin Project

class Node
  attr_accessor :value, :next_node, :prev_node

  def initialize(value)
    @value = value
    @next_node = nil
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
      #for the next node
      node.next_node = @head

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
      #for the next node
      @tail.next_node = node

      #And then, we append the new node to the head
      @tail = node
    end
  end

  def to_s
    node = @head

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
    p position

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


end

test = LinkedList.new

test.append(1)
test.append(2)
test.append(3)
test.append(4)
test.append(5)
test.prepend('text')

puts "Size of linked list is: #{test.size}"
test.to_s

puts "The value at a given index is: #{test.at(-7)}"
#The at(value) method needs work to return nil when index is negative and bigger than size


