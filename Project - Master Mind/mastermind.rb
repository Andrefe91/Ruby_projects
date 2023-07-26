class Board

  attr_accessor :board
  attr_writer :code

  def initialize (code)
    @board = {}
    @code = code
  end
end

class Player

  attr_accessor :name, :rol

  def initialize (name, rol)
    @name = name
    @rol = rol
  end
end

class computerPlayer
  def initialize
    @name = 'Computer Player'
  end
end
