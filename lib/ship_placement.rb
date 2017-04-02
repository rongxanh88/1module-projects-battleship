require './lib/board'
require './lib/comm'

class ShipPlacement
  include Communication
  attr_accessor :board, :difficulty

  def initialize(difficulty)
    @difficulty = difficulty
    generate_board
  end
  
  def generate_board
    @board = Board.new(5)
  end
  
end
