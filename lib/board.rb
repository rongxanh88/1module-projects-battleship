require './lib/constants'
require './lib/board_navigation'
require 'pry'

class Board
  include Constants, Navigation
  attr_accessor :board
  attr_reader :direction
  
  def initialize(size)
    @board = Array.new(size) {|row| Array.new(size) {|element| element = " "}}
    @direction = DIRECTION
  end

  def size
    row_length = board[0].length
  end
  
  def get_element(row_index, col_index)
    board[row_index][col_index]
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
    row, col = gen_random_indices(board.size)

    while (board[row][col] != " ") do
      row, col = gen_random_indices(board.size)
    end
    return row, col
  end

  def find_consecutive_empty_neighbors(first_index, second_index,
                                       ship_length, dir)
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

  def find_direction(start, last)
    first_row, first_col = convert_coordinate_to_indices(start)
    second_row, second_col = convert_coordinate_to_indices(last)

    if first_row == second_row
      num = second_col - first_col
      num > 0 ? direction = DIRECTION["E"] : direction = DIRECTION["W"]
    elsif first_col == second_col
      num = second_row - first_row
      num > 0 ? direction = DIRECTION["S"] : direction = DIRECTION["N"]
    end
    direction
  end
end