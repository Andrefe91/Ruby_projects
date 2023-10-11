class Board
  attr_reader :board_array

  #Initialize an empty array
  def initialize
    @board_array = Array.new(6, (Array.new(7, "\u{1F518}")))
  end

  def add_to_column(column, token)

  end

  def column_full?(column)
    return false unless column > 0 #Dont accept any column less than 1
    board_array[column-1] == "\u{1F518}" ? false : true
  end

  def available_row(column)
    row = 0

    6.times do |row_number|
      return row unless board_array[row_number][column-1] == "\u{1F518}"
      row = row_number
    end

    return 5
  end


end
