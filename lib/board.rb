require 'pry'
class Board
  attr_accessor :board
  attr_reader :direction
  
  def initialize(size)
    matrix = Array.new(size) {|row| Array.new(size) {|element| element = " "}}
    @board = matrix
    @direction = {
      "N" => [-1,0], "E" => [0, 1], "S" => [1, 0], "W" => [0, -1]
    }
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

  def find_ship_space(ship_length)
    ship_space = []
    row, col = grab_random_empty_space

    board[row][col] = "flagged"
    ship_space << [row, col]
    ship_length -= 1
    rand_dir = direction.to_a.sample(1).to_h
    direction = rand_dir.values.flatten
    ship_space << find_consecutive_empty_neighbors(row, col, ship_length, direction)
  end

  def grab_random_empty_space
    random_row = get_random_board_digit
    random_col = get_random_board_digit

    while (board[random_row][random_col] != " ") do
      random_row = get_random_board_digit
      random_col = get_random_board_digit
    end
    return random_row, random_col
  end
  

  def get_random_board_digit
    return Random.rand(1...board.size)
  end

  def find_consecutive_empty_neighbors(first_index, second_index, ship_length, dir)
    return if ship_length == 0
    neighbor = []
    target = " "
    start = [first_index, second_index]
    adjacent = start.zip(dir).map{|arr| arr.inject(:+)}
    row = adjacent[0]
    col = adjacent[1]
    if row < 0 or col < 0 or row >= board.size or col >= board.size
      return nil
    elsif board[row][col] == target
      neighbor << adjacent
      ship_length -= 1
      neighbor << find_consecutive_empty_neighbors(row, col, ship_length, dir)
    end
    neighbor
  end
  
  
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