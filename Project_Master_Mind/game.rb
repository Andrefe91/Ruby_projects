require './objects.rb'


class Game
  attr_accessor :role

  def initialize (role)
    @role = role
  end

  def print_message
    puts "Message: #{@role}"
  end


end

