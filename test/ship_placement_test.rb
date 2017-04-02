require './test/test_helper'
require './lib/ship_placement'

class ShipPlacementTest < Minitest::Test
  def test_instance_of_battle_ship
    player = ShipPlacement.new("beginner")
    assert_instance_of ShipPlacement, player
  end

  def test_board_creation
    player = ShipPlacement.new("beginner")
    assert_instance_of Board, player.board
  end
  
  def test_difficulty
    player = ShipPlacement.new("beginner")
    assert_equal "beginner", player.difficulty
  end

  def test_has_ships_for_beginner_game
    computer = ShipPlacement.new("beginner")
    assert_equal 2, computer.ships.size
  end

  def test_has_correct_ships_for_beginner_game
    computer = ShipPlacement.new("beginner")
    assert_equal [2,3], computer.ships
  end
  
  def test_place_computer_ships
    skip
    computer = ShipPlacement.new("beginner")
    computer.place_ships
  end
  
end