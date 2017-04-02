class Board
  attr_accessor :board
  def initialize(size)
    matrix = Array.new(size) {|row| Array.new(size) {|element| element = " "}}
    @board = matrix
  end

  def size
    row_length = board[0].length
  end
  
  def get_element(row_index, col_index)
    return board[row_index][col_index]
  end
  
  def set_element(row_index, col_index, element)
    board[row_index][col_index] = element
  end

  # def find_empty_space(ship_length)
  #   ship_space = []
  #   target = " "
  #   random_row = get_random_board_digit
  #   random_col = get_random_board_digit

  #   while (board[random_row][random_col] != target) do
  #     random_row = get_random_board_digit
  #     random_col = get_random_board_digit
  #   end

  #   board[random_row][random_col] = "flagged"
  #   ship_space << [random_row, random_col]
  #   ship_length -= 1
  #   ship_space << find_empty_neighbors(random_row, random_col, ship_length)
  # end

  def get_random_board_digit
    return Random.rand(1...board.size)
  end

  # def find_empty_neighbors(first_index, second_index, ship_length)
  #   return if ship_length == 0
  #   neighbor = []
  #   target = " "

  #   board.each_with_index do |row, row_index|
  #     row.each_with_index do |space, col_index|
  #       if (first_index == row_index) and
  #         ((col_index - second_index).abs <= 1) and
  #         space == target
  #           neighbors << [row_index, col_index]
  #           space == "flagged"
  #       elsif (col_index == second_index) and
  #         (row_index - first_index).abs <= 1) and
  #         space == target
  #           neighbors << [row_index, col_index]
  #           space == "flagged"
  #       end
  #     end
  #   end
  #   return neighbors << 
  # end
  
  
  # def find_live_cells
  #   locations = []
  #   board.each_with_index do |row, row_index|
  #     row.each_with_index do |element, col_index|
  #       if element == "alive"
  #         locations << [row_index, col_index]
  #       end
  #     end
  #   end
  #   locations
  # end

  # def find_neighbors(target="", row_index, col_index)
  #   neighbors = []
  #   board.each_with_index do |row, y_index|
  #     row.each_with_index do |element, x_index|
  #       if ((y_index - row_index).abs <= 1) and ((x_index - col_index).abs <= 1)
  #         if (y_index == row_index) and (x_index == col_index)
  #           #do nothing
  #         elsif element == target
  #           neighbors << [y_index, x_index]
  #         end
  #       end
  #     end
  #   end
  #   neighbors
  # end
end