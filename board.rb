class Board
  attr_accessor :board #lets us work with it throughout the file

  def initialize (row=3,col=3) #constructor for 3x3 board
    @board = Array.new(row){Array.new(col," - ")} 
  end

  def play_game
    counter = 0
    until winner? 
      place(which_symbol(counter))
      counter += 1
    end
  end
end

  def place(symbol) #places symbol and updates board
    loop do
      print "Enter row and column separated by a space: "
      input = gets.chomp  # Read the entire line of input
      r, c = input.split.map(&:to_i)  # Split the input and convert to integers
  
      if valid?(r, c)  # Check if the position is valid
        @board[r][c] = " "+symbol+" "  # Place the symbol on the board
        display  # Show the updated board
        break  # Exit the loop when a valid move is made
      else
        puts "Invalid position! Please try again."  # Prompt the user again if the position is invalid
      end
    end
  end

def valid?(r,c) #check if spot is on board and unused
  r<4 && c<4 && @board[r][c] == " - " 
end




def display #displays the current board
  @board.each { |row| puts row.join(" ")}
  3.times {puts ""}
end

def winner?
  if row_elements_same?
    puts "Winner"
    return true
  elsif col_elements_same?
    puts "Winner!"
    return true
  elsif diagonal_elements_same?
    puts "Winner!"
    return true
  else
    return false
  end
end

def row_elements_same?
  @board.any? do |row|
    row.uniq.length == 1 && row.first != " - "  # Ensures all elements in the row are the same and not empty
  end
end

def col_elements_same?
  @board[0].length.times do |col_index|
    return true if @board.all? { |row| row[col_index] == @board[0][col_index] && row[col_index] != " - " }
  end
  false
end

def diagonal_elements_same?
  # Check the primary diagonal (top-left to bottom-right)
  primary_diagonal = @board.each_with_index.all? { |row, i| row[i] == @board[0][0] && row[i] != " - " }

  # Check the secondary diagonal (top-right to bottom-left)
  secondary_diagonal = @board.each_with_index.all? { |row, i| row[(@board.length - 1) - i] == @board[0][@board.length - 1] && row[(@board.length - 1) - i] != " - " }

  primary_diagonal || secondary_diagonal
end

def which_symbol(num)
  num % 2 == 0 ? "X" : "O"
end


