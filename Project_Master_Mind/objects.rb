module RandomNumber
  def randomNumber
    number = []
    number[0] = rand(1..6)
    number[1] = rand(1..6)
    number[2] = rand(1..6)
    number[3] = rand(1..6)
    number.join
  end
end


class Board

  include RandomNumber
  attr_accessor :state, :code

  def initialize (code=0)
    @state = {}
    @code = (code == 0 ? randomNumber : code).to_s.split('').map { |s| s.to_i }
  end



  #Method used to register each guess and generate the "pegs"
  def use_guess(cracker_code)
    cracker_code = cracker_code.to_s.split('').map { |s| s.to_i }
    state[cracker_code] = key_pegs(cracker_code)
  end

  #Method used to return last pegs, usefull to check for the win condition
  def return_last_pegs
    state.values[state.length - 1]
  end

  def pretty_print
    puts "-----------------------------------------------"
    state.values.length.times do |i|
      puts "Turn #{i+1} | #{state.keys[i]} => #{state.values[i]}"
    end
    puts "-----------------------------------------------"
  end

  def empty?
    state.empty?
  end

  def full?
    max_number_of_turns = 12
    state.size >= 12 ? true : false
  end

  def win?
    return_last_pegs == ["@", "@", "@", "@"] ? true : false
  end

  def key_pegs(cracker_code)

    pegs = []
    awarded = []
    i = 0

    #Pegs determination algorithm
    cracker_code.each do |number|

      if number == @code[i]
        pegs.push('@')
      elsif (@code.include?(number) && !awarded.include?(number))
        pegs.push('O')
      end

      i += 1
      awarded.push(number)
    end

    pegs.sort_by { |each| each == '@' ? 0 : 1 }
  end
end

class HumanPlayer

  attr_accessor :name, :rol

  def initialize (name, rol)
    @name = name
    @rol = rol
  end
end

class ComputerPlayer
  include RandomNumber

  def initialize
    @name = 'Computer Player'
  end

end

