require './lib/comm'
require './lib/constants'
require './lib/validate'
require './lib/board_navigation'
require 'pry'

class Game
  include Communication, Constants, Navigation
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
    unless player_ships.empty? or comp_ships.empty?
      player_shot_message
      coordinate = ""
      unless valid_coordinate?(coordinate)
        coordinate = gets.chomp
      end
      row, col = convert_coordinate_to_indices(coordinate)
      result = fire_at_coordinate(row, col, comp_board)
      
      if result == "M"
        target_is_miss
      else
        target_is_hit
      end
      check_condition_of_ships(comp_board, comp_ships)
      computer_shoots
    end
  end

  def computer_shoots
    row, col = -1, -1
    unless grids_targeted.include?([row, col])
      row, col = gen_random_indices(player_board.size)
    end
    @grids_targeted << [row, col]
    result = fire_at_coordinate(row, col, player_board)
    if result == "M"
      target_is_miss
    else
      target_is_hit
      @target_stack.push([row, col])
    end
    check_condition_of_ships(player_board, player_ships)
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
    col_index = (coordinate.split("").last.to_i) - 1
    return row_index, col_index
  end

  def check_condition_of_ships(board, ships)
    temp_ships = ships
    temp_ships.each do |ship|
      flag = "dead"
      board.board.each do |row|
        row.each do |element|
          if element == ship.to_s
            flag = "alive"
          end
        end
      end
      ships.delete(ship) if flag == "dead"
    end
    return ships
  end
end