def merge_sort(array)
  return array if array.length <= 1

  if array.length == 2
    max = array.max
    array[0] = array.min
    array[1] = max
    return array
  end

  divided = array.each_slice((array.length*0.5).round).to_a
  sorted = divided.map {|sub_array| merge_sort(sub_array)}

  #p "[Debug] Array is #{array}"
  #p "[Debug] Sorted is: #{sorted}"

  #Assign pair of sorted arrays to new variables
  a = sorted[0]
  b = sorted[1]

  #Create new empty array for the sorted pair
  sorted_pair = []

  #Create a bucle to sort an n-dimensiona pair of arrays while no array is empty
  until b.first.nil? || a.first.nil?
    #Compare and find the minimun value from the first number of a and b arrays, pushing the result
    #to the sorted_pair array and repeat
    a.first < b.first ?
    sorted_pair.push(a.slice!(0)) : sorted_pair.push(b.slice!(0))
  end

  #Add whats left (that should be sorted) to the sorted_pair array and return
  sorted_pair.concat(a,b)

  return sorted_pair
end

p merge_sort([45,12,47,96,85,3])
