class Player
  attr_reader :name, :symbol

  @@symbols = ["\u{1F535}", "\u{1F534}"]
  @@player = 0

  def initialize(name)
    @name = name
    @symbol = @@symbols[@@player]
    @@player += 1
  end

end
