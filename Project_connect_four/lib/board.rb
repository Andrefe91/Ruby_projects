class Board
  attr_reader :win
  attr_accessor :board_array

  #Initialize an empty array
  def initialize
    @board_array = []
    @win = false

    6.times do |row|
      @board_array.append((Array.new(7, "\u{1F518}")))
    end
  end

  def add_to_column(column, token)
    return false if (column_full?(column)) #Dont to anything if the column is full
    row = available_row(column)

    @board_array[row][column-1] = token

    #For every added token, check if the win condition is satisfied
    win_check(row, column-1, token)

    #Return true so it can be check if the column was added successfully
    return true
  end

  def column_full?(column)
    return true unless column > 0 #Dont accept any column less than 1
    board_array[0][column-1] == "\u{1F518}" ?  false :  true
  end

  def available_row(column)
    row = 0

    6.times do |row_number|
      return row unless board_array[row_number][column-1] == "\u{1F518}"
      row = row_number
    end

    return 5
  end

  def pretty_print
    puts "The board as of now is: "
    puts "--------------------------------"
    6.times do |row|
      p board_array[row]
    end
    p [' 1',' 2',' 3',' 4',' 5',' 6', ' 7']
    puts "--------------------------------"
  end

  def win_check(rown, column, token)

    @win = true if column_win?(rown, column, token)
    @win = true if row_win?(rown, column, token)
    diagonal_win?(rown, column, token)
  end

  def column_win?(row, column, token)
    return false if row > 2

    #First, segment the column to check
    column_board = board_array.map {|row| row[column]}

    #Isolate the 4 tokens of interest
    column_segment = column_board[row..]

    repetition = column_segment.count(token)

    repetition >= 4 ? (return true) : (return false)
  end

  def row_win?(row, column, token)

    row_segment = @board_array[row]

    if column > 0  #To avoid a negative number while checking so we dont take the last token in the array
      #Check if the left token matches the player token
      while row_segment[column-1] == token
        column -= 1
      end
    end

    #Isolate the four token in line
    row_segment = row_segment.slice(column..(column+4))

    #Check for repetition
    repetition = row_segment.count(token)

    #Return if the win condition is fulfilled
    repetition >= 4 ? (return true) : (return false)
  end

  def diagonal_win?(row, column, token)

    board = @board_array

    row_right = row
    column_right = column

    row_left = row
    column_left = column

    diagonal_right = [token]
    diagonal_left = [token]

    #Main condition to check:
    #If the upper-right diagonal token is nil
    #If the column number is 0
    #If the upper-right diagonal token is the same as the player token

    unless  ( column > 0 || !(board[row-1][column-1] == token))
      row_right -= 1
      column_right -= 1
    end

    #Main condition to check:
    #If the upper-left diagonal token is nil
    #If the column number is 0
    #If the upper-left diagonal token is the same as the player token

    unless  ( column < 6 || !(board[row-1][column+1] == token))
      row_left -= 1
      column_left += 1
    end

    puts "Row Right: #{row_right}"
    puts "Row Left: #{row_left}"


    #Populate the diagonal right array from the board
    unless board[row_right + 1].nil?
      diagonal_right.append(board[row_right + 1][column_right + 1])
      row_right += 1
      column_right += 1
      puts "Row Right: #{row_right}"
      p board[row_right]
      puts "board[row_right + 2].nil?: #{board[row_right + 1].nil?}"
      p board[row_right+1]
    end

    #Populate the diagonal left array from the board
    unless board[row_left + 1].nil?
      diagonal_left.append(board[row_left + 1][column_left - 1])
      row_left += 1
      column_left -= 1
    end

    p diagonal_left
    p diagonal_right

    puts "Row Right: #{row_right}"
    puts "Row Left: #{row_left}"
  end

end

#test = Board.new
#test.pretty_print
