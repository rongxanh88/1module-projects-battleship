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
end