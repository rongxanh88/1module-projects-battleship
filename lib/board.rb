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
    length = ship_length - 1
    ship_space = []

    while ship_space.size < ship_length do
      ship_space.clear
      row, col = grab_random_empty_space
      ship_space << [row,col]
      rand_dir = (direction.to_a.sample(1).to_h).values.flatten
      ship_space << find_consecutive_empty_neighbors(row, col, length, rand_dir)
      ship_space = ship_space.flatten.compact.each_slice(2).to_a
    end
    ship_space
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
    start = [first_index, second_index]
    adjacent = start.zip(dir).map{|arr| arr.inject(:+)}
    row = adjacent[0]
    col = adjacent[1]
    if row < 0 or col < 0 or row >= board.size or col >= board.size
      return nil
    elsif board[row][col] == " "
      neighbor << adjacent
      ship_length -= 1
      neighbor << find_consecutive_empty_neighbors(row, col, ship_length, dir)
    end
    neighbor
  end
end