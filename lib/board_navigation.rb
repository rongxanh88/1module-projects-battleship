require './lib/constants'

module Navigation
  include Constants

  def gen_random_indices(board_size)
    row = Random.rand(0...board_size)
    col = Random.rand(0...board_size)
    return row, col
  end
  
  def convert_coordinate_to_indices(coordinate)
    row_index = ROWS[coordinate.split("").first]
    col_index = (coordinate.split("").last.to_i) - 1
    return row_index, col_index
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

  def get_adjacent_indices(first_index, second_index, dir)
    start = [first_index, second_index]
    adjacent = start.zip(dir).map{|arr| arr.inject(:+)}
    row = adjacent[0]
    col = adjacent[1]
    return row, col
  end
end