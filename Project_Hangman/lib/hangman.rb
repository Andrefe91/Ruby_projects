require './lib/objects.rb'
require 'csv'

puts "Hangman Game"

def random_word(file)
  file.readlines.map(&:chomp).select { |each| each.length >= 5}.sample
end


def main

  file = File.open('google-10000-english-no-swears.txt')


  game = Hangman.new(random_word(file),3)
  p game.word
  p game.pretty_print
  game.guess("a")
  p game.pretty_print
  game.guess("e")
  p game.pretty_print
  game.guess("i")
  p game.pretty_print
  game.guess("o")
  p game.pretty_print
  game.guess("u")
  p game.pretty_print
  game.guess("u")



end

main
