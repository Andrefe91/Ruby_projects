class Player
  attr_reader :name, :token, :number

  @@tokens = ["\u{1F535}", "\u{1F534}"]
  @@number = 0

  def initialize(name)
    @name = name
    @token = @@tokens[@@number]
    @number = @@number + 1
    @@number += 1
  end

end
