# Stock Picker implementation in Ruby for The Odin Project

def stock_picker(array)

  #Define the variables for the method
  results = []
  days = []
  array_length = array.length

  #For each day, compare with the next ones
  array.each_index do |index_buy|

    #Construct an array with the results of every comparison for which there is a profit
    (index_buy..array_length-1).each do |index_sell|
      if array[index_buy] <= array[index_sell]
        results.push([array[index_buy], array[index_sell], (array[index_sell] - array[index_buy])])
      end
    end
  end

  #Sort the results by profit and choose the first
  max_profit = (results.sort { |a, b| b[2] <=> a[2] })[0]

  #Find the two days indexes for which the bigger profit was found
  days.push(array.index(max_profit[0]))
  days.push(array.index(max_profit[1]))
  days
end


p stock_picker([17,3,6,9,15,8,6,1,10])
