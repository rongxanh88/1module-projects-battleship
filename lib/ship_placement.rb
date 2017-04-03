require './lib/board'
require './lib/comm'
require 'pry'

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
    when "b"
      @board = Board.new(4)
    when "i"
      @board = Board.new(8)
    when "a"
      @board = Board.new(12)
    end
  end

  def generate_ships
    case difficulty
    when "b"
      @ships = [2,3]
    when "i"
      @ships = [2,3,4]
    when "a"
      @ships = [2,3,4,5]
    end
  end
  
  def place_ships
    ships.each do |ship|
      empty_spaces = board.find_ship_space(ship)
      place(empty_spaces, ship)
    end
  end

  def place(empty_spaces, ship)
    empty_spaces.each do |space|
      row = space[0]
      col = space[1]
      board.set_element(row,col, ship.to_s)
    end
  end
  
  def select_ship_placement
    enter_coordinates_message
  end
end
