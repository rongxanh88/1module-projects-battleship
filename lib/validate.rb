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
    p rows
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
end