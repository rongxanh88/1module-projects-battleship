require './lib/board'
require './lib/comm'

class ShipPlacement
  include Communication
  attr_accessor :board, :difficulty, :ships

  def initialize(difficulty)
    @difficulty = difficulty
    generate_board
    generate_ships
  end
  
  def generate_board
    @board = Board.new(5) #easy 4x4 grid
  end

  def generate_ships
    case difficulty
    when "beginner"
      #makes a 2 unit and 3 unit boat
      @ships = [2,3]
    end
  end
  
  # def place_ships
  #   ships.each do |ship|
  #     empty_space = board.find_empty_space(ship.size)
  #     randomly_choose(empty_space)
  #     place(ship)
  #   end
  # end
  
end
