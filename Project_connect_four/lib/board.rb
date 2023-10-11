class Board
  attr_accessor :board_array

  #Initialize an empty array
  def initialize
    @board_array = []

    6.times do |row|
      @board_array.append((Array.new(7, "\u{1F518}")))
    end
  end

  def add_to_column(column, token)
    return false unless (column_full?(column)) #Dont to anything if the column is full

    row = available_row(column)

    @board_array[row][column-1] = token

    return true
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

test = Board.new

test.add_to_column(1,"\u{1F535}")

p test.board_array
