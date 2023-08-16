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
