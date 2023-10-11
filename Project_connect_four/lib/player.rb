class Player
  attr_reader :name, :token

  @@tokens = ["\u{1F535}", "\u{1F534}"]
  @@player = 0

  def initialize(name)
    @name = name
    @token = @@tokens[@@player]
    @@player += 1
  end

end
