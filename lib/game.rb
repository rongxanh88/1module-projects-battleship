require './lib/comm'
require './lib/constants'

class Game
  include Communication, Constants
  attr_accessor :player_board, :computer_board

  def initialize(player_board, computer_board)
    @player_board = player_board
    @computer_board = computer_board
  end
  
end
