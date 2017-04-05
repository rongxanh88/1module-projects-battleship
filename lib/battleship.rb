require './lib/comm'
require './lib/ship_placement'
require './lib/game'

class BattleShip
  include Communication
  attr_reader :difficulty, :computer_board, :player_board

  def initialize
    @difficulty = "b"
    start_game_sequence
  end

  private
  def start_game_sequence
    double_space
    main_menu_prompt
    main_menu_options
  end

  def main_menu_options
    answer = gets.chomp
    case answer
    when "p"
      play_game
    when "i"
      instructions
    when "q"
      abort("Left the game.")
    else
      incorrect_input
      start_game_sequence
    end
  end

  def play_game
    get_difficulty
    place_computer_ships
    place_player_ships
    game = Game.new(player_board, computer_board, difficulty)
  end
  
  def instructions 
    go_back = "a"
    while go_back != "b"
      show_game_instructions
      go_back = gets.chomp
    end
    start_game_sequence
  end
  
  def place_player_ships
    player = ShipPlacement.new(difficulty)
    player_place_ships_message(difficulty)
    @player_board = player.select_ship_placement
  end
  
  def place_computer_ships
    computer = ShipPlacement.new(difficulty)
    computer.place_ships
    @computer_board = computer.board
    computer_placed_ships
  end
  
  def get_difficulty
    ans = ""
    while (ans != "b") and (ans != "i") and (ans != "a") do
      select_difficulty
      ans = gets.chomp
    end
    @difficulty = ans
  end
end

new_game = BattleShip.new