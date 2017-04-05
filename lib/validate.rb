require './lib/constants'
require './lib/board_navigation'

class Validate
  include Constants, Navigation
  attr_accessor :board

  def initialize(board)
    @board = board
  end

  def validate(coordinate)
    rows = Hash[ROWS.sort_by { |k,v| v }[0...board.size]]
    row, col = convert_coordinate_to_indices(coordinate)
    if col < 0 or col > (board.size - 1) or !rows.has_value?(row)
      return false
    end
    return true
  end

  def validate_length(coordinates, length)
    start, last = split_into_two_coordinates(coordinates)
    first_row, first_col = convert_coordinate_to_indices(start)
    second_row, second_col = convert_coordinate_to_indices(last)

    if same_letter?(start, last)
      return false if (first_col - second_col).abs != (length - 1)
    elsif same_number?(start, last)
      return false if (first_row - second_row).abs != (length - 1)
    end
    true
  end

  def validate_in_line(coordinates)
    start, last = split_into_two_coordinates(coordinates)

    if same_letter?(start, last) or
      same_number?(start, last)
      return true
    end
    return false
  end

  def validate_all_empty(coordinates)
    start, last = split_into_two_coordinates(coordinates)
    if same_letter?(start, last)
      row_empty?(start.to_s, last.to_s)
    elsif same_number?(start, last)
      column_empty?(start.to_s, last.to_s)
    end
  end

  def same_letter?(first_coord, second_coord)
    first_coord[0] == second_coord[0]
  end

  def same_number?(first_coord, second_coord)
    first_row, first_col = convert_coordinate_to_indices(first_coord)
    second_row, second_col = convert_coordinate_to_indices(second_coord)
    return first_col == second_col
  end

  def column_empty?(first_coord, second_coord)
    first_row, first_col = convert_coordinate_to_indices(first_coord)
    second_row, second_col = convert_coordinate_to_indices(second_coord)
    if second_row > first_row
      iterate_through_line(first_row, second_row, first_col, "col")
    elsif first_row > second_row
      iterate_through_line(second_row, first_row, first_col, "col")
    end
  end

  def row_empty?(first_coord, second_coord)
    first_row, first_col = convert_coordinate_to_indices(first_coord)
    second_row, second_col = convert_coordinate_to_indices(second_coord)
    if second_col > first_col
      iterate_through_line(first_col, second_col, first_row, "row")
    elsif first_col > second_col
      iterate_through_line(second_col, first_col, first_row, "row")
    end
  end

  def iterate_through_line(first_line, second_line, number, line_type)
    while first_line <= second_line do
      if line_type == "col"
        element = board.get_element(first_line, number)
      else
        element = board.get_element(number, first_line)
      end
      return false if element != " "
      first_line += 1
    end
    return true
  end
end