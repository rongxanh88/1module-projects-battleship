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
  
  def computer_placed_ships
    double_space
    puts "The computer has placed the ships on the board."
    double_space
  end
  
  def double_space
    puts "\n\n"
  end
  
end
