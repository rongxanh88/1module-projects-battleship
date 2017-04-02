require './lib/comm'

class BattleShip
  include Communication

  attr_reader :difficulty, :player_board, :computer_ships

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
      #select_difficulty
      place_player_ships
      @computer_ships = place_computer_ships
    when "i"
      go_back = "a"
      while go_back != "b"
        show_game_instructions
        go_back = gets.chomp
      end
      start_game_sequence
    when "q"
      abort("Left the game.")
    else
      incorrect_input
      start_game_sequence
    end
  end

  # def place_player_ships
  #   player = ShipPlacement.new(difficulty)
  #   player.place_ships
  # end
  
  # def place_computer_ships
  #   computer = ShipPlacement.new(difficulty)
  #   computer.place_ships
  # end
  

end

#new_game = BattleShip.new