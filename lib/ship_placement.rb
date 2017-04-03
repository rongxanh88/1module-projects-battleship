require './lib/board'
require './lib/comm'
require './lib/validate'
require './lib/constants'
require 'pry'

class ShipPlacement
  include Communication, Constants
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
    ships.each do |ship|
      enter_coordinates_message(ship)
      coordinates = gets.chomp
      start = coordinates.split(" ").first
      last = coordinates.split(" ").last
      row_index = ROWS[start.split("").first]
      col_index = start.split("").last.to_i - 1
      direction = board.find_direction(start, last)
      if validate_coordinates(coordinates, ship)
        empty_spaces = board.find_consecutive_empty_neighbors(
          row_index, col_index, ship - 1, direction)
        empty_spaces.flatten!.compact!
        empty_spaces = empty_spaces.each_slice(2).to_a
        empty_spaces.unshift([row_index, col_index])
        place(empty_spaces, ship)
      else
        redo
      end
    end
  end

  def validate_coordinates(coordinates, ship_length)
    validator = Validate.new(board)
    start = coordinates.split(" ").first
    last = coordinates.split(" ").last
    return false unless validator.validate(start)
    return false unless validator.validate(last)
    return false unless validator.validate_in_line(start, last)
    return false unless validator.validate_all_empty(start, last)
    return false unless validator.validate_length(start, last, ship_length)
    return true
  end
end
