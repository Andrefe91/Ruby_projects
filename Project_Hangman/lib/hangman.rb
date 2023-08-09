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
  puts "Game saved !!"
end

def load_file(filename)
  #Open the file with a rescue clause in case the file doesn't exist
  begin
    File.open(filename + ".yaml", 'r') do |file|
      object =  YAML.safe_load(file, permitted_classes: [Hangman])
      #Return the object or else stop existing after the block
      return object
    end
  rescue Errno::ENOENT
    puts "Error, no file found for file \"#{filename}.yaml\""
  end
end

def main
  #Open reference file
  file = File.open('google-10000-english-no-swears.txt')

  %{
  game = Hangman.new(random_word(file),6)
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
  game.guess("u")

  object = YAML.dump(game)
  puts object

  other = YAML.safe_load(object, permitted_classes: [Hangman])

  puts other.pretty_print

  puts "Specify the name of the Save File: "
  filename = gets.chomp
  save_file(filename, game)
  }

  puts "Name of the Save File to open: "
  filename = gets.chomp
  object = load_file(filename)
  p object.nil?

  #Only Pretty Print the object if it isnt nil, so no "NoMethodError" is raised
  (puts object.pretty_print) unless object.nil?




end

main
