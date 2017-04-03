require './lib/constants'

class Validate
  include Constants
  attr_accessor :board

  def initialize(board)
    @board = board
  end

  def validate(coordinate)
    split_coordinate = coordinate.split("")
    rows = Hash[ROWS.sort_by { |k,v| v }[0...board.size]]
    row = split_coordinate[0]
    col = split_coordinate[1].to_i
    if col < 1 or col > board.size
      false
    elsif rows.has_key?(row) == false
      false
    else
      true
    end
  end

  def validate_in_line(first_coord, second_coord)
    first_split = first_coord.split("")
    second_split = second_coord.split("")
    letter, number = 0, 1

    if same_letter?(first_split, second_split) or
      same_number?(first_split, second_split)
      true
    else
      false
    end
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
      iterate_through_row(first_row_num, second_row_num, number)
    elsif first_row_num > second_row_num
      iterate_through_row(second_row_num, first_row_num, number)
    end
  end

  def row_empty?(first_coord, second_coord)
    letter = first_coord[0]
    first_num = first_coord[1].to_i
    second_num = second_coord[1].to_i
    row_num = ROWS[letter]
    if second_num > first_num
      iterate_through_col(first_num, second_num, row_num)
    elsif first_num > second_num
      iterate_through_col(second_num, first_num, row_num)
    end
  end

  def iterate_through_row(first_row, second_row, col)
    while first_row <= second_row do
      element = board.get_element(first_row, col)
      if element != " "
        return false
      end
      first_row += 1
    end
    return true
  end

  def iterate_through_col(first_col, second_col, row)
    while first_col <= second_col do
      element = board.get_element(row, first_col)
      if element != " "
        return false
      end
      first_col += 1
    end
    return true
  end
end