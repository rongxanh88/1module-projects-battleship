require './lib/constants'
require './lib/board_navigation'
require 'pry'

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
    number = first_coord[1].to_i
    first_row_num = ROWS[first_letter]
    second_row_num = ROWS[second_letter]
    if second_row_num > first_row_num
      iterate_through_line(first_row_num, second_row_num, number, "row")
    elsif first_row_num > second_row_num
      iterate_through_line(second_row_num, first_row_num, number, "row")
    end
  end

  def row_empty?(first_coord, second_coord)
    letter = first_coord[0]
    first_num = first_coord[1].to_i
    second_num = second_coord[1].to_i
    row_num = ROWS[letter]
    
    if second_num > first_num
      iterate_through_line(first_num, second_num, row_num, "col")
    elsif first_num > second_num
      iterate_through_line(second_num, first_num, row_num, "col")
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