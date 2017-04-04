require './lib/comm'
require './lib/constants'
require './lib/validate'

class Game
  include Communication, Constants
  attr_accessor :player_board, :comp_board, :player_ships, :comp_ships
  attr_reader :difficulty

  def initialize(player_board, comp_board, difficulty)
    @player_board = player_board
    @comp_board = comp_board
    @difficulty = difficulty
    @player_ships = SHIPS[difficulty]
    @comp_ships = SHIPS[difficulty]

    #initiate_war_message
    #shooting_loop
  end

  def shooting_loop
    while !player_ships.empty? or !comp_ships.empty? do
      player_shot_message
      coordinate = ""
      while !valid_coordinate?(coordinate) do
        coordinate = gets.chomp
      end
      fire_at_coordinate(coordinate, comp_board)
    end
  end
  
  def valid_coordinate?(coordinate)
    validator = Validate.new(comp_board)
    validator.validate(coordinate)
  end

  def fire_at_coordinate(coordinate, board)
    row_index = ROWS[coordinate.split("").first]
    col_index = coordinate.split("").last.to_i - 1
    element = board.get_element(row_index, col_index)

    if TARGET_ID.has_key?(element)
      board.set_element(row_index, col_index, "H")
    else
      board.set_element(row_index, col_index, "M")
    end
    return board.get_element(row_index, col_index)
  end
  
end
