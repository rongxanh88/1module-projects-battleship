require './test/test_helper'
require './lib/ship_placement'

class ShipPlacementTest < Minitest::Test
  def test_instance_of_battle_ship
    player = ShipPlacement.new("easy")
    assert_instance_of ShipPlacement, player
  end

  def test_board_creation
    player = ShipPlacement.new("easy")
    assert_instance_of Board, player.board
  end
  
  def test_difficulty
    player = ShipPlacement.new("easy")
    assert_equal "easy", player.difficulty
  end
end