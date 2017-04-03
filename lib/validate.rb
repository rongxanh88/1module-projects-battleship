require './lib/constants'

class Validate
  include Constants
  attr_accessor :board

  def initialize(board)
    @board = board
  end

  def validate(coordinate)
    split_coordinate = coordinate.split("")
    rows = Hash[ROWS.sort_by { |key,value| value }[0...board.size]]
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

    if (first_split[letter] == second_split[letter]) or
      (first_split[number] == second_split[number])
      true
    else
      false
    end
  end

  def validate_all_empty(first_coord, second_cood)

  end
end