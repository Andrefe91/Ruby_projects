#Method for the Fibonacci sequence

def fibs(n)
  array = [0,1]
  (n-2).times {|step| array << array[step] + array[step+1] }
  array
end

#Method for the Fibonacci sequence with recursive iteration

def fibs_rec(n,array = [0,1])
  array.length == n ? (return array) : fibs_rec(n,array.append(array[-1] + array[-2]))
end

#p fibs(10000)


def divide_array(array, sorted = [])
  #p "And sorted array: #{sorted}"
  #p "#{array} and array.length: #{array.length}"
  (array.each_slice((array.length*0.5).round) {|divided| divide_array(divided, sorted)}) if array.length > 2

  p "Array is #{array}"


  if array.length == 2
    max = array.max
    array[0] = array.min
    array[1] = max
  else
    array
  end

  p "Array length is: #{array.length}"

  p "After function recursion: #{array}"
  array
end

p divide_array([4,7,3,1,9,5,7])
