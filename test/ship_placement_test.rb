require './test/test_helper'
require './lib/ship_placement'

class ShipPlacementTest < Minitest::Test
  def test_instance_of_ship_placement
    player = ShipPlacement.new("b")
    assert_instance_of ShipPlacement, player
  end

  def test_board_size
    player = ShipPlacement.new("b")
    assert_equal 4, player.board.size
    player1 = ShipPlacement.new("i")
    assert_equal 8, player1.board.size
    player2 = ShipPlacement.new("a")
    assert_equal 12, player2.board.size
  end
  
  def test_difficulty
    player = ShipPlacement.new("b")
    assert_equal "b", player.difficulty
  end

  def test_has_ships_for_beginner_game
    computer = ShipPlacement.new("b")
    assert_equal 2, computer.ships.size
  end

  def test_has_correct_ships_for_beginner_game
    computer = ShipPlacement.new("b")
    assert_equal [2,3], computer.ships
  end
  
  def test_has_ships_for_intermediate_game
    computer = ShipPlacement.new("i")
    assert_equal 3, computer.ships.size
  end

  def test_has_correct_ships_for_intermediate_game
    computer = ShipPlacement.new("i")
    assert_equal [2,3,4], computer.ships
  end

  def test_has_ships_for_advanced_game
    computer = ShipPlacement.new("a")
    assert_equal 4, computer.ships.size
  end

  def test_has_correct_ships_for_advanced_game
    computer = ShipPlacement.new("a")
    assert_equal [2,3,4,5], computer.ships
  end

  def test_place_computer_ships
    computer = ShipPlacement.new("b")
    computer.place_ships
  end

  def test_validate_coordinates
    player = ShipPlacement.new("b")
    assert player.validate_coordinates("A1 A3", 3)
    refute player.validate_coordinates("A1B2", 2)
    refute player.validate_coordinates("A1 A3", 2)
  end

  def test_player_place_ships
    skip #works but skip due to REPL interface
    player = ShipPlacement.new("b")
    player.select_ship_placement
  end
end