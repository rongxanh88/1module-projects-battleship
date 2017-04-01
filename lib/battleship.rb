require '../lib/comm'

class BattleShip
  include Communication

  def initialize
    start_game_sequence
  end

  def start_game_sequence
    main_menu_prompt
    answer = gets.chomp

    case answer
    when "p"
      #enter ship layout
    when "i"
      #print instructions to screen, then return to start_game_sequence
    when "q"
      abort("Left the game.")
    else
      incorrect_input
      start_game_sequence
    end
  end
end

new_game = BattleShip.new