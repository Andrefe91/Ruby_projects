
def count_sub_string (string, dictionary)
  string = string.downcase
  result = {}

  #The matches of the substrings are easily returned with the gsub method for strings
  dictionary.each do |value|
    count = 0
    string.gsub(value) {|match| count += 1}
    result[value] = count
  end

  #We can delete the entries from the hatch that have a value of zero
  result_prunned = result.delete_if {|key, value| value == 0}

end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

#Get the phrase from the user
puts "Please enter the phrase: "
string = gets.chomp

#Saving the result to print
result =  count_sub_string(string, dictionary)

puts "The results are: #{result}"

