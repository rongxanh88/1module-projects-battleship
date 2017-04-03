module Communication

  def main_menu_prompt
    puts "Welcome to BATTLESHIP\n\n"
    puts "Would you like to (p)lay, read the (i)nstructions, " +
         "or (q)uit?\n"
  end

  def incorrect_input
    puts "Please re-enter your choice."
  end
  
  def show_game_instructions
    double_space
    puts "The game of BattleShip is played by you and the computer.\n" + 
    "The gameboard is sized according to the difficulty selected.\n" +
    "First you and the computer will place ships on the board.\n" +
    "After placement, you will alternate firing at the enemy. The first\n" +
    "to hit and sink the opponent's ships, wins. Firing coordinates are\n" +
    "labeled by their columns, from 1 to n. Rows are labeled by letter from\n" +
    "the letter 'A'. Good luck, and may the best navy win!"
    double_space
    puts "Go (b)ack"
  end
  
  def select_difficulty
    double_space
    puts "Please select difficulty setting."
    double_space
    puts "(b)eginner, (i)ntermediate, (a)dvanced"
  end
  
  def computer_placed_ships
    double_space
    puts "The computer has placed the ships on the board."
  end
  
  def player_place_ships_message(difficulty)
    start_grid = "A1"
    additional_units = ""
    case difficulty
    when "b"
      num_ships = 2
      end_grid = "D4"
    when "i"
      num_ships = 3
      end_grid = "H8"
      additional_units = "The third is four units long.\n"
    when "a"
      num_ships = 4
      end_grid = "L12"
      additional_units = "The third is four units long.\n" +
                        "The fourth is five units long.\n"
    end

    double_space
    puts "You now need to layout your #{num_ships} ships.\n" +
         "The first is two units long and the\n" +
         "second is three units long.\n" +
         additional_units +
         "The grid has #{start_grid} at the top left and #{end_grid} at the bottom right."
  end

  def enter_coordinates_message(ship_size)
    double_space
    puts "You are placing a ship of #{ship_size} units in length.\n" +
         "Please enter the beginning and end coordinates like so:\n" +
         "A1 D1"
  end
  
  def double_space
    puts "\n\n"
  end
end
