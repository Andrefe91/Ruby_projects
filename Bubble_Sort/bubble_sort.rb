#Build a method #bubble_sort that takes an array and returns a sorted array.
#It must use the bubble sort methodology (using #sort would be pretty pointless, wouldn’t it?).

# > bubble_sort([4,3,78,2,0,2])
#=> [0,2,2,3,4,78]

#Implementation for the exercise Bubble Sort for The Odin Project

#While this exercise is about bubble sorting, the implemented algorithm is slightly different,
#it runs trough the data structure once and as soon as the condition is matched (second < first)
#it starts again until no longer the condition is satisfied.

def bubble_sort (array)
  #For each element in the array sort the values
  (0..array.length-2).each do |index|
    a = array[index]
    b = array[index + 1]

    #Run trough the values and sort once, then use recursion to sort again
    if a > b
      array[index + 1] = a
      array[index] = b

      #Recursion sort
      bubble_sort(array)
    end
  end
  array
end

p bubble_sort([4,3,78,2,0,2])
#=> [0, 2, 2, 3, 4, 78]
