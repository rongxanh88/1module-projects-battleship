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
      #look along column
    elsif same_number?(first_split, second_split)
      #look along row
    end
  end

  def same_letter?(first_coord, second_coord)
    first_coord[0] == second_coord[0]
  end

  def same_number?(first_coord, second_coord)
    first_coord[1] == second_coord[1]
  end

  def column_empty?(first_coord, second_coord)

  end

  def row_empty?(first_coord, second_coord)

  end
end