require './lib/objects.rb'
require 'csv'
require 'yaml'

puts "Hangman Game"

def random_word(file)
  #From file, select a word at random
  file.readlines.map(&:chomp).select { |each| each.length >= 5}.sample
end

def save_file(filename, object)
  #Saving file to root directory
  File.open(filename + ".yaml", 'w') do |file|
    file.write(YAML.dump(object))
  end
  print_space("Game saved !!")
end

def load_file
  print "Name of the Save Game to load: "
  filename = gets.chomp
  #Open the file with a rescue clause in case the file doesn't exist
  begin
    File.open(filename + ".yaml", 'r') do |file|
      object =  YAML.safe_load(file, permitted_classes: [Hangman])
      print_space("Game loaded !!")
      #Return the object or else stop existing after the block
      return object
    end
  rescue Errno::ENOENT
    puts "** Error, no file found under the name: \"#{filename}.yaml\" **"
  end
end

def print_space(phrase)
  #Prints the lines for messages format
  puts "****************************************"
  (1..(39-phrase.length)/2).each { |each| print " " }
  print " #{phrase} "
  (1..(39-phrase.length)/2).each { |each| print " " }
  puts ""
  puts "****************************************"
end

def new_game
  print "Alright, a new random word is gonna be choosen, write the desired number of turns: "

  while
    turns = gets.chomp.to_i
    break unless turns == 0
    print_error("number")
    print "Write the desired number of turns: "
  end

  #Open the file with the given word list and choose a random one
  file = File.open('google-10000-english-no-swears.txt')
  game = Hangman.new(random_word(file),turns)
  print_space("Game Created, starting...")
  return game
end

def player_selection
  puts 'Game Modes'
  puts '-------------'
  puts '1 - New Game'
  puts '2 - Load Game'

  print 'Select an option: '
  selection = gets.chomp

  if selection == '1'
    return new_game
  elsif selection == '2'
    return load_file
  else
    print_error ("option")
    player_selection
  end

end

def print_error (word)
  puts "\n"
  puts '-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-'
  puts "Sorry, invalid #{word}. Try again"
  puts '-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-'
  puts "\n"
end

def main
  puts '-----------------------------------------------------'
  puts 'Welcome to Hang-Man, a Ruby implementation on console'
  puts '-----------------------------------------------------'
  game_object = player_selection

  #Only Pretty Print the object if it isnt nil, so no "NoMethodError" is raised
  (puts game_object.pretty_print) unless game_object.nil?

  #Calls the method to add a letter to the Hangman object or bring the option to save the game to file




  %{
  puts game.word
  puts game.pretty_print
  game.guess("a")
  puts game.pretty_print
  game.guess("e")
  puts game.pretty_print
  game.guess("i")
  puts game.pretty_print
  game.guess("o")
  puts game.pretty_print
  game.guess("u")
  puts game.pretty_print
  game.guess("u")}

end

main
