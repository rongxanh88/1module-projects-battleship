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

  def validate_length(first_coord, second_coord, length)
    first_split = first_coord.split("")
    second_split = second_coord.split("")

    if same_letter?(first_split, second_split)
      first_num = first_split[1].to_i
      second_num = second_split[1].to_i
      return false if (first_num - second_num).abs != (length - 1)
    elsif same_number?(first_split, second_split)
      first_num = ROWS[first_split[0]]
      second_num = ROWS[second_split[0]]
      return false if (first_num - second_num).abs != (length - 1)
    end
    true
  end

  def validate_in_line(first_coord, second_coord)
    first_split = first_coord.split("")
    second_split = second_coord.split("")

    if same_letter?(first_split, second_split) or
      same_number?(first_split, second_split)
      return true
    end
    return false
  end

  def validate_all_empty(first_coord, second_coord)
    first_split = first_coord.split("")
    second_split = second_coord.split("")

    if same_letter?(first_split, second_split)
      row_empty?(first_split, second_split)
    elsif same_number?(first_split, second_split)
      column_empty?(first_split, second_split)
    end
  end

  def same_letter?(first_coord, second_coord)
    first_coord[0] == second_coord[0]
  end

  def same_number?(first_coord, second_coord)
    first_coord[1] == second_coord[1]
  end

  def column_empty?(first_coord, second_coord)
    first_letter = first_coord[0]
    second_letter = second_coord[0]
    col = first_coord[1].to_i
    first_row = ROWS[first_letter]
    second_row = ROWS[second_letter]
    if second_row > first_row
      iterate_through_line(first_row, second_row, col, "row")
    elsif first_row > second_row
      iterate_through_line(second_row, first_row, col, "row")
    end
  end

  def row_empty?(first_coord, second_coord)
    letter = first_coord[0]
    first_col = first_coord[1].to_i
    second_col = second_coord[1].to_i
    row = ROWS[letter]
    
    if second_col > first_col
      iterate_through_line(first_col, second_col, row, "col")
    elsif first_col > second_col
      iterate_through_line(second_col, first_col, row, "col")
    end
  end

  def iterate_through_line(first_line, second_line, number, line_type)
    while first_line <= second_line do
      if line_type == "row"
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