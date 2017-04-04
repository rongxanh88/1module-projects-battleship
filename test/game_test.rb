require './test/test_helper'
require './lib/game'
require './lib/board'
require 'pry'

class GameTest < Minitest::Test
  def test_instance_of_game
    player_board = Board.new(4)
    computer_board = Board.new(4)
    game = Game.new(player_board, computer_board)
    assert_instance_of Game, game
  end
end