require './lib/board'
require './lib/comm'
require './lib/validate'
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
  
  # def select_ship_placement
  #   ships.each do |ship|
  #     enter_coordinates_message(ship)
  #     coordinates = gets.chomp
  #     validate_coordinates(coordinates, ship)
  #   end
  # end

  def validate_coordinates(coordinates, ship_length)
    validator = Validate.new(board)
    is_valid = true
    start = coordinates.split(" ").first
    last = coordinates.split(" ").last
    is_valid = false unless validator.validate(start)
    is_valid = false unless validator.validate(last)
    is_valid = false unless validator.validate_in_line(start, last)
    is_valid = false unless validator.validate_all_empty(start, last)
    is_valid = false unless validator.validate_length(start, last, ship_length)
    is_valid
  end
end
