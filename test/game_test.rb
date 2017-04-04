require './test/test_helper'
require './lib/game'
require './lib/board'
require 'pry'

class GameTest < Minitest::Test
  # def test_instance_of_game
  #   player_board = Board.new(4)
  #   comp_board = Board.new(4)
  #   game = Game.new(player_board, comp_board, "b")
  #   assert_instance_of Game, game
  # end

  def test_fire_at_coordinate
    player_board = Board.new(4)
    comp_board = Board.new(4)
    comp_board.set_element(0,1, "2")
    game = Game.new(player_board, comp_board, "b")
    
    assert_equal "M", game.fire_at_coordinate(0, 0, comp_board)
    assert_equal "H", game.fire_at_coordinate(0, 1, comp_board)
  end

  def test_computer_shoots
    player_board = Board.new(4)
    comp_board = Board.new(4)
    player_board.set_element(0,0, "2")
    game = Game.new(player_board, comp_board, "b")
    game.computer_shoots
  end

  def test_get_random_indexes
    player_board = Board.new(4)
    comp_board = Board.new(4)
    game = Game.new(player_board, comp_board, "b")
    row, col = game.gen_random_indices
    assert row > 0
    assert row < player_board.size
    assert col > 0
    assert col < player_board.size
  end
end