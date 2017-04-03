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
    case difficulty
    when "beginner"
      @board = Board.new(4)
    when "intermediate"
      @board = Board.new(8)
    when "advanced"
      @board = Board.new(12)
    end
  end

  def generate_ships
    case difficulty
    when "beginner"
      @ships = [2,3]
    when "intermediate"
      @ships = [2,3,4]
    when "advanced"
      @ships = [2,3,4,5]
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
