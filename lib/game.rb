require './lib/comm'
require './lib/constants'
require './lib/validate'
require './lib/board_navigation'
require './lib/board'
require 'pry'

class Game
  include Communication, Constants, Navigation
  attr_accessor :player_board, :comp_board, :player_ships, :comp_ships,
                :target_stack, :grids_targeted, :target_board
  attr_reader :difficulty

  def initialize(player_board, comp_board, difficulty)
    @player_board = player_board
    @comp_board = comp_board
    @target_board = Board.new(player_board.size)
    @difficulty = difficulty
    #@target_stack = []
    @grids_targeted = []
    setup_ships
    initiate_war_message
    shooting_loop
  end

  def setup_ships
    case difficulty
    when "b"
      @player_ships = [2,3]
      @comp_ships = [2,3]
    when "i"
      @player_ships = [2,3,4]
      @comp_ships = [2,3,4]
    when "a"
      @player_ships = [2,3,4,5]
      @comp_ships = [2,3,4,5]
    end
  end

  def shooting_loop
    start = Time.now
    while !player_ships.empty? or !comp_ships.empty? do
      player_shoots
      computer_shoots
    end
    finish = Time.now
    player_ships.empty? ? player_loses_message : player_wins_message
    shots_fired_message(grids_targeted)
    puts "Time elapsed: #{finish - start} seconds."
  end

  def player_shoots
    print_board(target_board)
    player_shot_message
    coordinate = ""
    while !valid_coordinate?(coordinate) do
      coordinate = gets.chomp
    end
    row, col = convert_coordinate_to_indices(coordinate)
    result = fire_at_coordinate(row, col, comp_board)
    @target_board.set_element(row, col, result)

    if result == "M"
      target_is_miss
    else
      target_is_hit
    end
    check_condition_of_ships(comp_board, comp_ships)
    print_board(target_board)
    press_enter_to_end_turn
  end

  def computer_shoots
    computer_shot_message
    row, col = gen_random_indices(player_board.size)
    while grids_targeted.include?([row, col]) do
      row, col = gen_random_indices(player_board.size)
    end
    @grids_targeted << [row, col]
    result = fire_at_coordinate(row, col, player_board)
    if result == "M"
      target_is_miss
    else
      target_is_hit
      #@target_stack.push([row, col])
    end
    #print_board(player_board)
    sleep 1
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

  def check_condition_of_ships(person, ships)
    cur_num_ships = ships
    cur_num_ships.each do |ship|
      flag = "dead"
      person.board.each do |row|
        row.each do |element|
          flag = "alive" if element == ship.to_s
        end
      end
      ships.delete(ship) if flag == "dead"
    end
    #return ships
  end

  def print_board(board)
    letters = Hash[ROWS.sort_by { |k,v| v }[0...board.size]]

    print_border
    print_row_label(board.size)
    print_whole_board(board, letters)
    print_border
  end

  def press_enter_to_end_turn
    press_enter_message
    ans = ""
    while ans != "\n"
      ans = gets
    end
  end
end