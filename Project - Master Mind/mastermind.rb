module RandomNumber
  def randomNumber
    rand(1111..6666)
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
  def guess(cracker_code)
    cracker_code = cracker_code.to_s.split('').map { |s| s.to_i }
    state[cracker_code] = key_pegs(cracker_code)
  end

  #Method used to return last pegs, usefull to check for the win condition
  def return_last_pegs
    state.values[state.length - 1]
  end

  private

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
      else
        pegs.push('_')
      end

      i += 1
      awarded.push(number)
    end
    pegs
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
  def initialize
    @name = 'Computer Player'
  end
end


board = Board.new(1111)

board.guess(1234)
board.guess(6514)
board.guess(1444)
board.guess(1111)
p board.state
p board.return_last_pegs
