require './lib/constants'
require 'pry'

class Board
  include Constants
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

  def get_random_board_digit
    return Random.rand(1...board.size)
  end

  def find_direction(start, last)
    first_row = ROWS[start[0]]
    second_row = ROWS[last[0]]
    first_col = start[1].to_i
    second_col = last[1].to_i

    if first_row == second_row
      num = second_col - first_col
      if num > 0
        direction = DIRECTION["E"]
      else
        direction = DIRECTION["W"]
      end
    elsif first_col == second_col
      num = second_row - first_row
      if num > 0
        direction = DIRECTION["S"]
      else
        direction = DIRECTION["N"]
      end
    end
    return direction
  end
end