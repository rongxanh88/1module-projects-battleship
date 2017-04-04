require './lib/comm'
require './lib/constants'
require './lib/validate'

class Game
  include Communication, Constants
  attr_accessor :player_board, :comp_board, :player_ships, :comp_ships,
                :target_stack, :grids_targeted
  attr_reader :difficulty

  def initialize(player_board, comp_board, difficulty)
    @player_board = player_board
    @comp_board = comp_board
    @difficulty = difficulty
    @player_ships = SHIPS[difficulty]
    @comp_ships = SHIPS[difficulty]
    @target_stack = []
    @grids_targeted = []

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
      row, col = convert_coordinate_to_indices(coordinate)
      result = fire_at_coordinate(coordinate, comp_board)
      
      if result == "M"
        target_is_miss
      else
        target_is_hit
      end
      computer_shoots
    end
  end

  def computer_shoots
    row, col = -1, -1
    while !grids_targeted.include?([row, col]) do
      row, col = gen_random_indices
    end
    @grids_targeted << [row, col]
    result = fire_at_coordinate(row, col, player_board)
    if result == "M"
      target_is_miss
    else
      target_is_hit
      @target_stack.push([row, col])
    end
  end

  def gen_random_indices
    row = Random.rand(1...player_board.size)
    col = Random.rand(1...player_board.size)
    return row, col
  end
  
  def valid_coordinate?(coordinate)
    validator = Validate.new(comp_board)
    validator.validate(coordinate)
  end

  def fire_at_coordinate(row, col, board)
    element = board.get_element(row, col)

    if TARGET_ID.has_key?(element)
      board.set_element(row, col, "H")
      ship_hit_message(TARGET_ID[element])
    else
      board.set_element(row, col, "M")
    end
    return board.get_element(row, col)
  end
  
  def convert_coordinate_to_indices(coordinate)
    row_index = ROWS[coordinate.split("").first]
    col_index = coordinate.split("").last.to_i - 1
    return row_index, col_index
  end
end
