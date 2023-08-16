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


def divide_array(array)
  return array if array.length <= 1

  if array.length == 2
    max = array.max
    array[0] = array.min
    array[1] = max
    return array
  end

  divided = array.each_slice((array.length*0.5).round).to_a
  sorted = divided.map {|sub_array| divide_array(sub_array)}

  p "Array is #{array}"
  p "Sorted is: #{sorted}"

  return sorted
end

p divide_array([4,7,3,1,9,5,7])

def recurrent(array=[0])
  p 'First'
  (array.push(1) && recurrent(array)) if array.length < 8
  array.push('a')
end

#p recurrent([1])
