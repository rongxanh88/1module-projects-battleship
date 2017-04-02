require './lib/comm'

class BattleShip
  include Communication

  attr_reader :difficulty

  def initialize
    @difficulty = "easy"
    start_game_sequence
  end

  def start_game_sequence
    double_space
    main_menu_prompt
    answer = gets.chomp

    case answer
    when "p"
      #select_difficulty
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
end

#new_game = BattleShip.new