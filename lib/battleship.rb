require './lib/comm'

class BattleShip
  include Communication
  attr_reader :difficulty

  def initialize
    @difficulty = "beginner"
    start_game_sequence
  end

  def start_game_sequence
    double_space
    main_menu_prompt
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
  end
  
  def instructions 
    go_back = "a"
    while go_back != "b"
      show_game_instructions
      go_back = gets.chomp
    end
    start_game_sequence
  end
  
  # def place_player_ships
  #   player = ShipPlacement.new(difficulty)
  #   player.place_ships
  # end
  
  # def place_computer_ships
  #   computer = ShipPlacement.new(difficulty)
  #   computer.place_ships
  # end
  
  def get_difficulty
    select_difficulty
    answer = ""
    while answer != ("b" or "i" or "a") do
      answer = gets.chomp
    end
    @difficulty = answer
  end
end

#new_game = BattleShip.new