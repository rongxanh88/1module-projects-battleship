require './lib/board'
require './lib/comm'
require './lib/validate'
require './lib/constants'
require './lib/board_navigation'

class ShipPlacement
  include Communication, Constants, Navigation
  attr_accessor :board, :difficulty, :ships

  def initialize(difficulty)
    @difficulty = difficulty
    @board = Board.new(BOARD_SIZE[difficulty])
    @ships = SHIPS[difficulty]
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
      start, last = split_into_two_coordinates(coordinates)
      row, col = convert_coordinate_to_indices(start)
      direction = find_direction(start, last)
      if validate_coordinates(coordinates, ship)
        empty_spaces = board.find_empty_neighbors(
          row, col, ship - 1, direction)
        empty_spaces.flatten!.compact!
        empty_spaces = empty_spaces.each_slice(2).to_a
        empty_spaces.unshift([row, col])
        place(empty_spaces, ship)
      else
        redo
      end
    end
    board
  end

  def validate_coordinates(coordinates, ship_length)
    validator = Validate.new(board)
    start, last = split_into_two_coordinates(coordinates)
    return false unless validator.validate(start)
    return false unless validator.validate(last)
    return false unless validator.validate_in_line(coordinates)
    return false unless validator.validate_all_empty(coordinates)
    return false unless validator.validate_length(coordinates, ship_length)
    return true
  end
end
