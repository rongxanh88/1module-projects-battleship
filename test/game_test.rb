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
    skip
    player_board = Board.new(4)
    comp_board = Board.new(4)
    player_board.set_element(0,0, "2")
    game = Game.new(player_board, comp_board, "b")
    game.computer_shoots
  end

  def test_convert_coordinates_to_indices
    player_board = Board.new(4)
    comp_board = Board.new(4)
    game = Game.new(player_board, comp_board, "b")
    row, col = game.convert_coordinate_to_indices("A1")

    assert_equal 0, row
    assert_equal 0, col
  end

  def test_valid_coordinates
    player_board = Board.new(4)
    comp_board = Board.new(4)
    game = Game.new(player_board, comp_board, "b")

    assert game.valid_coordinate?("A1")
    refute game.valid_coordinate?("Z2")
  end

  def test_check_condition_of_ships
    player_board = Board.new(4)
    player_board.set_element(0,0, "2")
    player_board.set_element(0,1, "3")
    comp_board = Board.new(4)
    game = Game.new(player_board, comp_board, "b")
    ships = game.player_ships
    result = game.check_condition_of_ships(player_board, ships)
    assert_equal [2,3], result

    player_board.set_element(0,0, "H")
    game2 = Game.new(player_board, comp_board, "b")
    result = game2.check_condition_of_ships(player_board, ships)
    assert_equal [3], result

    player_board.set_element(0,1, "H")
    game3 = Game.new(player_board, comp_board, "b")
    result = game3.check_condition_of_ships(player_board, ships)
    assert_equal [], result
  end
end