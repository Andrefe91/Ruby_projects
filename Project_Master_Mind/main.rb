require './objects.rb'
require './game.rb'
require 'pry-byebug'

def player_selection
  puts '1 - Code Maker'
  puts '2 - Code Cracker'

  print 'Whats your selected role?: '
  selection = gets.chomp

  if selection == '1'
    return 'Maker'
  elsif selection == '2'
    return 'Cracker'
  else
    puts "\n"
    puts '-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-'
    puts 'Sorry, invalid selection. Try again'
    puts '-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-'
    puts "\n"
    player_selection
  end

end



def start

  puts '---------------------------------------------------------'
  puts 'Welcome to Master Mind, a Ruby implementation on console'
  puts '---------------------------------------------------------'
  puts 'First, Choose and option:'
  p player_selection

end

start
